Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA35F393A14
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 02:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhE1ANp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 20:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhE1ANo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 20:13:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5EFD613B4;
        Fri, 28 May 2021 00:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622160731;
        bh=mGn/UBIb72f59+beDKg+xosBmmYPcK2f7QnlOh5bj8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3fIHIqCTLbZ8wBalRe9ODIGj3TgudKBJB19r4zMEH1uwxs3ue1gMSBV3VTNIwpZd
         cD2UZIg/08zERYAjgIPbOY60V7AzelRnpoPpEAnrMXevD2b/wEwpbwlETSsLZcC1St
         gN2rIl0t3Thu26vg4bSRczjyJaHPP3Ax/Mh3TZOmr2OM6gUWEqfFqtdAvDBZ3NXkx3
         i3sReqSyFc1LCX+TrH0208L3Aisx0rgaaRt5REKbWeYlp3Cl5drTVCjHSbc1/geXJe
         8k5J2i/KARmk8RgnCBsTp9wWle0ZNnng2WnAhJwVUyKm6IQBvuWZ1i6HMED+mfsGfT
         xloWwsrzLp3MQ==
Received: by pali.im (Postfix)
        id 9839C894; Fri, 28 May 2021 02:12:08 +0200 (CEST)
Date:   Fri, 28 May 2021 02:12:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org,
        =?utf-8?B?UsO2dHRp?= 
        <espressobinboardarmbiantempmailaddress@posteo.de>
Subject: Re: [PATCH] PCI: Add Max Payload Size quirk for ASMedia ASM1062 SATA
 controller
Message-ID: <20210528001208.z4g4f7wlu65dxypj@pali>
References: <20210317115924.31885-1-kabel@kernel.org>
 <20210511181612.1d017bb7@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210511181612.1d017bb7@thinkpad>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 11 May 2021 18:16:12 Marek Behún wrote:
> Ping? :)
> 
> Marek

Bjorn: Gentle reminder :)
