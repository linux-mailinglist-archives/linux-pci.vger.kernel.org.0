Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653873770A3
	for <lists+linux-pci@lfdr.de>; Sat,  8 May 2021 10:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhEHIVq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 May 2021 04:21:46 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:49533 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHIVp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 May 2021 04:21:45 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 219C72800B3D2;
        Sat,  8 May 2021 10:20:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0408D57556; Sat,  8 May 2021 10:20:42 +0200 (CEST)
Date:   Sat, 8 May 2021 10:20:42 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on
 s2idle
Message-ID: <20210508082042.GA18309@wunner.de>
References: <20210506220738.GA2150@wunner.de>
 <20210507133002.GA1499665@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507133002.GA1499665@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 07, 2021 at 08:30:02AM -0500, Bjorn Helgaas wrote:
> Apart from that, what I don't like about this (and about the original
> 1df5172c5c25) is that there's no connection to a spec or to documented
> behavior of the device or of suspend/resume.
> 
> For example, "With s2idle, the machine isn't suspended via ACPI, so
> the AML code which powers the controller off isn't executed."  AFAICT
> that isn't actually a required, documented property of s2idle, but
> rather it reaches into the internal implementation.

Actually I'm not sure whether AML code is involved here, I may have mixed
up terms.  To the best of my knowledge, macOS doesn't use s2idle, at least
not on such older MacBooks.  It either puts the machine into ACPI S3
(S2RAM) or S4 (hibernate, suspend to disk).  The Thunderbolt controller's
power rail is off in ACPI S3 and S4.

A peculiarity of the "Cactus Ridge" Thunderbolt 1 controller built into
2012/2013 era MacBooks is that it requires execution of the ACPI methods
in quirk_apple_poweroff_thunderbolt() before power is cut.  Otherwise
the controller is dead when power is reinstated and a cold reboot is
required to resurrect it.  At least that's my understanding, I don't
own a machine with such a chip.  Neither older controllers (such as the
2011 era "Light Ridge") nor newer controllers (such as 2013/2014
"Falcon Ridge") need the quirk.

The ACPI methods seem to fiddle with GPIOs which are connected to
the Force Power, Go2Sx and Ok2Go2Sx pins of the Cactus Ridge controller.
The meaning of the ACPI methods and the pins isn't documented publicly,
it's all reverse-engineered from the macOS driver and leaked schematics.
Some educated guesses as to their meaning are contained in my Thunderbolt
runtime PM patches of 2016:

https://github.com/l1k/linux/commit/65f56e6c8446

 * * On Macs with Thunderbolt 1 Gen 2 controllers (Cactus Ridge 4C):
[...]
 *   * Additional SXFP method ("Force Power"), accepts only argument 0,
 *     switches the controller off. This carries out just the raw power change,
 *     unlike XRPE which disables the link on the PCIe Root Port in an orderly
 *     fashion before switching off the controller.
 *   * Additional SXLV, SXIO, SXIL methods to utilize the Go2Sx and Ok2Go2Sx
 *     pins (see background below). Apparently SXLV toggles the value given to
 *     the POC via Go2Sx (0 or 1), SXIO changes the direction (0 or 1) and SXIL
 *     returns the value received from the POC via Ok2Go2Sx.
[...]
 * * On gen 2 controllers (Cactus Ridge 4C), Intel integrated the MCU into the
 *   controller and called it POC. This caused a change of semantics for XRIN
 *   and XRIL. The POC is powered by a separate 3.3V rail which is active even
 *   in sleep state S4. It only draws a very small current. The regular 3.3V
 *   and 1.05V power rails are no longer controlled by the southbridge but by
 *   the POC. In other words the controller powers *itself* up and down! It is
 *   instructed to do so with the Go2Sx pin. Another pin, Ok2Go2Sx, allows the
 *   controller to indicate if it is ready to power itself down. Apple wires
 *   Go2Sx and Ok2Go2Sx to the same GPIO pin on the southbridge, hence the pin
 *   is used bidirectionally. A third pin, Force Power, is intended by Intel
 *   for debug only but Apple abuses it for XRPE/TRPE and SXFP. Perhaps it
 *   leads to larger power saving gains. They utilize Go2Sx and Ok2Go2Sx only
 *   on Cactus Ridge, presumably because the controller somehow requires that.
 *   On Falcon Ridge they forego these pins and rely solely on Force Power.

With s2idle, the machine never transitions to ACPI S3 or S4.  Consequently,
power to the controller isn't cut, but the quirk prepares it for the
S3/S4 transition.  When the system is woken from s2idle, the chip is
apparently inaccessible.  Solution is to either not execute the PCI quirk
at all (as is done by the present patch) or to undo the quirk when waking
from s2idle.  We don't know how to do the latter, it would have to be
reverse-engineered.  Maybe it can't be done at all with the available
ACPI methods.

Thanks,

Lukas
