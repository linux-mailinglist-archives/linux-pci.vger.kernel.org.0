Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4891F44EA19
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 16:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhKLPfC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 10:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229509AbhKLPfB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 10:35:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFBC360EBD;
        Fri, 12 Nov 2021 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636731131;
        bh=kKRhDzHtRFfUXSKAuOEAK80vLG3pkJ5tWmulI3l4RTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLpvW4NB7E/wWiS9lWf8SIo4K+NMTtgb7Lv40EaNCI6aqux5UKpA8zezkGKS5knKg
         Dt9VMIPRA/QNVfrWTzTyyx9YzvHnH7GQb+oJ+dhlue7Tf+R9obguWYsAnUidG8d3Hp
         L0LDX170AQhX8rlYT1eTH5LF7xNTc4yBjOIngDhVREpexLcWnLKpc2NS5qAvUAL/eE
         J8piJ7soVdQd3rMfMJtm3j/Dh0U4XSk2jJ5GIzwb+1FbfUECOWOAJeFhRt9JcMYN37
         QUDmJ1SL+pwVxDGGS+w2/edit8ocQQo0SQ9+IesnVCNw0WUSjmUqU9OjgFiV+A7fAV
         FtqDxHqJAwIBA==
Received: by pali.im (Postfix)
        id 92D6C79D; Fri, 12 Nov 2021 16:32:08 +0100 (CET)
Date:   Fri, 12 Nov 2021 16:32:08 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add
 'slot-power-limit-milliwatt' PCIe port property
Message-ID: <20211112153208.s4nuckz7js4fipce@pali>
References: <20211031150706.27873-1-kabel@kernel.org>
 <YY6HYM4T+A+tm85P@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YY6HYM4T+A+tm85P@robh.at.kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 12 November 2021 09:25:20 Rob Herring wrote:
> On Sun, Oct 31, 2021 at 04:07:05PM +0100, Marek Behún wrote:
> > +   If present, this property specifies slot power limit in milliwatts. Host
> > +   drivers can parse this property and use it for programming Root Port or host
> > +   bridge, or for composing and sending PCIe Set_Slot_Power_Limit messages
> > +   through the Root Port or host bridge when transitioning PCIe link from a
> > +   non-DL_Up Status to a DL_Up Status.
> 
> If your slots are behind a switch, then doesn't this apply to any bridge 
> port?

The main issue here is that pci.txt (and also scheme on github) is
mixing host bridge and root ports into one node. This new property
should be defined at the same place where is supports-clkreq or
reset-gpios, as it belongs to them.

And you are right, that this new property should be defined only for
root ports and downstream ports of switch.
