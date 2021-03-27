Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3830534B882
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 18:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhC0ReD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 13:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230043AbhC0Rda (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 27 Mar 2021 13:33:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08E9B619AE;
        Sat, 27 Mar 2021 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616866410;
        bh=oxyLYLefehpWosmb5y5Pli16dqH1dyu9Z35XDlG8ET0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQXaQob413Eg6E56SJ8wTkqWk9NuTG34Apv0JcwAKGYMjnNn33LGum+D+t7gTyWyH
         lojMX41ea2R9C9cd/yrn/IgxUT1xO4NgYRbw0WRKb55UOEnt/s6rEuRa36wSmop6UB
         wbU6uMoA35DrwNx1QcJrseH9+DbH5aazyNWNn3+l3wSdo7z7/AzxYId1+uUGq13c/A
         rLAIzrW8MvxEZpl5qi0iBXlU6G486nxvTrBMybqIL6N3Op5msIGG6Pk99SQw8gOSaM
         vLXBnUnzLhTDEqR1z/9IEjqJNbkK9fHIRDvmVF1ejmU0RhFCSz7Qk9IZXHDlwiLWpG
         y55ZIdi19uv9w==
Received: by pali.im (Postfix)
        id 6551195D; Sat, 27 Mar 2021 18:33:27 +0100 (CET)
Date:   Sat, 27 Mar 2021 18:33:27 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Disallow retraining link for Atheros QCA98xx chips
 on non-Gen1 PCIe bridges
Message-ID: <20210327173327.tfn4mjq3cvrq33qu@pali>
References: <20210326124326.21163-1-pali@kernel.org>
 <YF540gjh156QIirA@rocinante>
 <20210327132959.fwkphna7gg57aove@pali>
 <20210327154213.571aa263@dellmb.labs.office.nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210327154213.571aa263@dellmb.labs.office.nic.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 27 March 2021 15:42:13 Marek Behún wrote:
> On Sat, 27 Mar 2021 14:29:59 +0100
> Pali Rohár <pali@kernel.org> wrote:
> 
> > I can change this to 'if (!ret)' if needed, no problem.
> > 
> > I use 'if (!val)' mostly for boolean and pointer variables. If
> > variable can contain more integer values then I lot of times I use
> > '=='.
> 
> Comparing integer varibales with explicit literals is sensible, but
> if a function returning integer returns 0 on success and negative value
> on error, Linux kernel has a tradition of using just
>   if (!ret)
> or 
>   if (ret)
> 
> Marek

Ok, I will change it.
