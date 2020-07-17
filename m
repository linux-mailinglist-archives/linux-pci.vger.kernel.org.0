Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627952244A2
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 21:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgGQTwP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 15:52:15 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:53651 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgGQTwO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2020 15:52:14 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id E02A030000CF7;
        Fri, 17 Jul 2020 21:52:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A84152B0C74; Fri, 17 Jul 2020 21:52:09 +0200 (CEST)
Date:   Fri, 17 Jul 2020 21:52:09 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Karol Herbst <kherbst@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
Message-ID: <20200717195209.vmtyfmgweoo645lh@wunner.de>
References: <20200716235440.GA675421@bjorn-Precision-5520>
 <ec6623032131fc3e656713b8ec644cdff89a8066.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec6623032131fc3e656713b8ec644cdff89a8066.camel@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 17, 2020 at 03:04:10PM -0400, Lyude Paul wrote:
> Isn't it possible to tell whether a PCI device is connected through
> thunderbolt or not? We could probably get away with just defaulting
> to 100ms for thunderbolt devices without DLL Link Active specified,
> and then default to the old delay value for non-thunderbolt devices.

pci_is_thunderbolt_attached()
