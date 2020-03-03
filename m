Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4AB517716E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 09:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgCCIoy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 03:44:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:43174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbgCCIoy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 03:44:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 09E6DAFB1;
        Tue,  3 Mar 2020 08:43:56 +0000 (UTC)
Message-ID: <1583225019.12738.6.camel@suse.com>
Subject: Re: [PATCH v3 0/4] Raspberry Pi 4 VL805 firmware load support
From:   Oliver Neukum <oneukum@suse.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, wahrenst@gmx.net,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Date:   Tue, 03 Mar 2020 09:43:39 +0100
In-Reply-To: <20200302155528.19505-1-nsaenzjulienne@suse.de>
References: <20200302155528.19505-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Montag, den 02.03.2020, 16:55 +0100 schrieb Nicolas Saenz Julienne:
> On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> loaded directly from an EEPROM or, if not present, by the SoC's
> VideCore. This series adds support for the later.

What happens if runtime PM strikes, in particular, how do
you deal with D4cold?

	Regards
		Oliver
