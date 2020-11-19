Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2C12B90BB
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 12:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgKSLMI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 06:12:08 -0500
Received: from foss.arm.com ([217.140.110.172]:53424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgKSLMI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 06:12:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CCED1396;
        Thu, 19 Nov 2020 03:12:07 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C2DF3F718;
        Thu, 19 Nov 2020 03:12:06 -0800 (PST)
Date:   Thu, 19 Nov 2020 11:12:01 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Yue Wang <yue.wang@amlogic.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc/meson: do not fail on wait linkup timeout
Message-ID: <20201119111201.GA19942@e121166-lin.cambridge.arm.com>
References: <20200921074953.25289-1-narmstrong@baylibre.com>
 <CAL_JsqLZzxXcvoqd29NM45UjL-mbSiHphTO_zOwbCwPKd+jWEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLZzxXcvoqd29NM45UjL-mbSiHphTO_zOwbCwPKd+jWEw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 11:30:30AM -0600, Rob Herring wrote:
> On Mon, Sep 21, 2020 at 1:50 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > When establish link timeouts, probe fails but the error is unrelated since
> > the PCIe controller has been probed succesfully.
> >
> > Align with most of the other dw-pcie drivers and ignore return of
> > dw_pcie_wait_for_link() in the host_init callback.
> 
> I think all, not most DWC drivers should be aligned. Plus the code
> here is pretty much the same, so I'm working on moving all this to the
> common DWC code. Drivers that need to bring up the link will need to
> implement .start_link() (currently only used for EP mode). Most of the
> time that is just setting the LTSSM bit which Synopsys thought letting
> every vendor do their own register for was a good idea. Sigh.

Should I drop this patch then ?

Thanks,
Lorenzo
