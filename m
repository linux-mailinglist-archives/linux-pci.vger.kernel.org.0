Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE9C3442D4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 13:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhCVMpe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 08:45:34 -0400
Received: from foss.arm.com ([217.140.110.172]:59154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhCVMnb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 08:43:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C6891063;
        Mon, 22 Mar 2021 05:43:31 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 667843F718;
        Mon, 22 Mar 2021 05:43:29 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:43:26 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        minghuan.Lian@nxp.com, Mingkai Hu <mingkai.hu@nxp.com>,
        Roy Zang <roy.zang@nxp.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>, robh@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] pci/controller/dwc: convert comma to semicolon
Message-ID: <20210322124326.GD11469@e121166-lin.cambridge.arm.com>
References: <20201216131944.14990-1-zhengyongjun3@huawei.com>
 <20210106190722.GA1327553@bjorn-Precision-5520>
 <20210115113654.GA22508@e121166-lin.cambridge.arm.com>
 <YEUdSZpwzg0k5z2+@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YEUdSZpwzg0k5z2+@rocinante>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 07, 2021 at 07:36:57PM +0100, Krzysztof Wilczyński wrote:
> Hi,
> 
> [...]
> > I would request NXP maintainers to take this patch, rewrite it as
> > Bjorn requested and resend it as fast as possible, this is a very
> > relevant fix.
> [...]
> 
> Looking at the state of the pci-layerscape-ep.c file in Linus' tree,
> this still hasn't been fixed, and it has been a while.
> 
> NXP folks, are you intend to pick this up?  Do let us know.

Minghuan, Mingkai, Roy,

either one of you reply and follow up this patch or I will have to
update the MAINTAINERS entry and take action accordingly, you are
not maintaining this driver and I won't maintain your code, sorry.

Lorenzo

> Krzysztof
