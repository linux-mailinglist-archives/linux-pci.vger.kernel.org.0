Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8992015D643
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2020 12:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgBNLHC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Feb 2020 06:07:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:53702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729007AbgBNLHC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Feb 2020 06:07:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 59713B383;
        Fri, 14 Feb 2020 11:07:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20200213025930.27943-3-jaedon.shin@gmail.com>
Date:   Fri, 14 Feb 2020 12:01:58 +0100
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Andrew Murray" <amurray@thegoodpenguin.co.uk>,
        "Gregory Fong" <gregory.0xf0@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <bgolaszewski@baylibre.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, "Jaedon Shin" <jaedon.shin@gmail.com>
Subject: Re: [PATCH 2/3] PCI: brcmstb: Add regulator support
From:   "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
To:     "Jaedon Shin" <jaedon.shin@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>
Message-Id: <C0LU3KQRE3WZ.3EDDA7IKJ2T3X@linux-9qgx>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu Feb 13, 2020 at 11:59 AM, Jaedon Shin wrote:
> @@ -173,8 +174,79 @@ struct brcm_pcie {
> int gen;
> u64 msi_target_addr;
> struct brcm_msi *msi;
> +#ifdef CONFIG_REGULATOR

Correct me if I'm wrong, but I don't think these #ifdefs are necessary
(same below). The regulator code defines empty functions and relevant
structures even when not enabled.

Regards,
Nicolas
