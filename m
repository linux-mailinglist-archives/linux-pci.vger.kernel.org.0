Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFDFBD71A3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 10:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfJOI6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 04:58:09 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:43551 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfJOI6J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 04:58:09 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191015085805epoutp02d1ad548eb0a4cfd889ce6467a1f3a59e~Nxk5u7pv20461804618epoutp02J
        for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2019 08:58:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191015085805epoutp02d1ad548eb0a4cfd889ce6467a1f3a59e~Nxk5u7pv20461804618epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571129885;
        bh=/SFjdGEguceZTF7NEb52JQoFAQABsBxr02etVYuqG90=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=m7diCTvn5nehpv+jSdDNgmh53XYU/2S8CnKWUX83OKh2bQYmi+7pXM2sIgdV5M40u
         lSDBb4iCg1yN2gbjS0KK09q4ImHZNJ/0pmmtvwyQI9apXIS8swBddODGL2WMRM3NB0
         3ANTJyQBs/v76VmAh0Q5o5PYZktE7N8TlVJlE3eQ=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191015085804epcas5p3e68e5a44a0db35daded764030b19c280~Nxk5PGJ8L2155121551epcas5p3m;
        Tue, 15 Oct 2019 08:58:04 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.CE.04660.C1A85AD5; Tue, 15 Oct 2019 17:58:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20191015085803epcas5p1cb269eaa0e9d130983c4eff8966dc505~Nxk4foDqi3031830318epcas5p1-;
        Tue, 15 Oct 2019 08:58:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191015085803epsmtrp23f6f2eb594212cb425064e54893e50eb~Nxk4e076B0871908719epsmtrp2F;
        Tue, 15 Oct 2019 08:58:03 +0000 (GMT)
X-AuditID: b6c32a4a-60fff70000001234-93-5da58a1c749b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.2C.03889.B1A85AD5; Tue, 15 Oct 2019 17:58:03 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191015085801epsmtip2f5b8fabf4e76f52fa5875ad052c174e3~Nxk2o1f3g0476004760epsmtip2P;
        Tue, 15 Oct 2019 08:58:01 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Christoph Hellwig'" <hch@infradead.org>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>, <andrew.murray@arm.com>,
        <lorenzo.pieralisi@arm.com>, <gustavo.pimentel@synopsys.com>,
        <jingoohan1@gmail.com>, <vidyas@nvidia.com>,
        "'Anvesh Salveru'" <anvesh.s@samsung.com>
In-Reply-To: <20191015081620.GA28204@infradead.org>
Subject: RE: [PATCH v3] PCI: dwc: Add support to add GEN3 related
 equalization quirks
Date:   Tue, 15 Oct 2019 14:28:00 +0530
Message-ID: <068001d58336$a76ed970$f64c8c50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI32j4iOCLbX1pxMrCw4/raoiQM8gHGBYnvAqR4VLGmc18X0A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeyyVcRjH+53b+zocvQ7l6WSps2LO5lbMa0Oty3rXtMw/SoxT3iGOY+dF
        qbbckkvMqC0nHeQaWoW5HJEdcaawNbc/TK3RkmuLomHyeln+++x5vt99v8/24HypUSjDI2Pi
        aE2MMlouEguauhwUjjZZFcEu+blyMnWjWUj260uFZHlKBKkfz8DIj3nPeWT1UiFGDuqLRGS/
        zigiZ1enMHKkWXJKTNXp6hDVqh3HqJL6eKqhWkHlpM6LqNzGGkQ1vltE1GL9IT88UOwVRkdH
        JtAaZ59QccRosUEQ+8H81rQumZ+E1kyzkAkOhBtkJz0WZSExLiXaELzoq0PsQkr8QlA4J+P4
        D4Kudt8dw6O33RhnaEdQ9nJ62z2DQN+9JmRVIsIZBlZ0W2xFOEJ/6RRiRXwimwevJx6I2IUJ
        cQLepCzwWLYkAkBbO4uxLCCOQU326JZGQnjC2EIr4tgCegsnBSzzCVtonivic5UOw99vldth
        p2Ei3yjkNNbwo/v9VlUgCjDoqWrAOMNZSO7IQxxbwrSxcXsug8X5dhHHalgpy+dz5jQEBcZn
        Qm5xEjqHijZb4JsJDvBK78yFmUPO6iSPHQMhgYx0Kae2g+Xvfds9beBragWPYwrahgsFeeiI
        dtdp2l2naXedoP0fVoIENegAHcuowmnGPfZ4DH3TiVGqmPiYcKfralU92novxYUWVDnga0AE
        juRmEiKtPFgqVCYwiSoDApwvt5IUsyNJmDLxNq1Rh2jio2nGgA7iArm1JF84HCQlwpVxdBRN
        x9KanS0PN5ElIbn9kKN+xbUz0GwQQq/6Mb/triTv6elwur//YhlELd3pD3jyU3NDtu/cZ/UT
        C8cRei88vfYlM8291tLbWWy4G221jqmW7TwuuzQ2tSRWae29PNdNfc70efuP54TkLI0F2SkW
        z881VF5S+0sL4o9u3JtJL3/Y+cmtqddDIrfNrF6XC5gIpauCr2GU/wAWvDMyWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvK5019JYg6N3DCya/29ntTi7ayGr
        xZKmDItddzvYLU5PWMRkseLLTHaLy7vmsFmcnXeczeLN7xfsFte28zpweayZt4bRY+esu+we
        CzaVemxeoeXR2/yOzaNvyypGjy37PzN6fN4kF8ARxWWTkpqTWZZapG+XwJVxff4hloJTfBWv
        5jUyNzD+4e5i5OSQEDCRmLLnKHsXIxeHkMBuRokpfzYxQiRkJCavXsEKYQtLrPz3HKroJaPE
        5Qlb2UESbAL6Eud+zAMrEhHQlTi78AUjSBGzwFQmiZWrvzGDJIQEDjJK3J0oAWJzChhLbGx6
        zwRiCwuEStyePB1sG4uAqsSq7utsIDavgKXE7fc7GSFsQYmTM5+wdDFyAA3Vk2jbCBZmFpCX
        2P52DjPEcQoSP58ug7rBSeLxpOOsEDXiEi+PHmGfwCg8C8mkWQiTZiGZNAtJxwJGllWMkqkF
        xbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMERqKW1g/HEifhDjAIcjEo8vBltS2KFWBPLiitz
        DzFKcDArifDObwEK8aYkVlalFuXHF5XmpBYfYpTmYFES55XPPxYpJJCeWJKanZpakFoEk2Xi
        4JRqYJzvkM6rdviC0Ab5yCmPNE/sT3mnNP3asbr4z5wh/lkqs78EWwcqNl6Y01Hd6Ny40MBu
        s5D9xjBrRpErmq0PmZkNbHff+npjOdtC10T/N69FopMMgjJWb7v1/rB6oNS24sUBC2c+8dC9
        27zC9UTR6WKOoF2Vfp4RZ/8dyC1J2+VZFTqvjKVwrRJLcUaioRZzUXEiACqDA+C8AgAA
X-CMS-MailID: 20191015085803epcas5p1cb269eaa0e9d130983c4eff8966dc505
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191015025933epcas5p1f0891dacc13648559ed8e037e49ee5b1
References: <CGME20191015025933epcas5p1f0891dacc13648559ed8e037e49ee5b1@epcas5p1.samsung.com>
        <1571108362-25962-1-git-send-email-pankaj.dubey@samsung.com>
        <20191015081620.GA28204@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Tuesday, October 15, 2019 1:46 PM
> To: Pankaj Dubey <pankaj.dubey@samsung.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; andrew.murray@arm.com; lorenzo.pieralisi@arm.com;
> gustavo.pimentel@synopsys.com; jingoohan1@gmail.com; vidyas@nvidia.com;
> Anvesh Salveru <anvesh.s@samsung.com>
> Subject: Re: [PATCH v3] PCI: dwc: Add support to add GEN3 related
equalization
> quirks
> 
> On Tue, Oct 15, 2019 at 08:29:22AM +0530, Pankaj Dubey wrote:
> > From: Anvesh Salveru <anvesh.s@samsung.com>
> >
> > In some platforms, PCIe PHY may have issues which will prevent linkup
> > to happen in GEN3 or higher speed. In case equalization fails, link
> > will fallback to GEN1.
> >
> > DesignWare controller gives flexibility to disable GEN3 equalization
> > completely or only phase 2 and 3 of equalization.
> >
> > This patch enables the DesignWare driver to disable the PCIe GEN3
> > equalization by enabling one of the following quirks:
> >  - DWC_EQUALIZATION_DISABLE: To disable GEN3 equalization all phases
> >  - DWC_EQ_PHASE_2_3_DISABLE: To disable GEN3 equalization phase 2 & 3
> >
> > Platform drivers can set these quirks via "quirk" variable of "dw_pcie"
> > struct.
> 
> Please submit this together with the changes to the dwc frontend driver
that
> actually wants to set these quirks.

Is this something mandatory?

As we discussed during first patch-set here [1] with Andrew, we have need of
this patch (along with some other stuffs, which will be sent soon), to clean
up our internal driver and make it ready for upstream. As of today we have
some internal restrictions where we can't make it to upstream along with
this patch. 

[1]: https://patchwork.ozlabs.org/patch/1160310/#2258262

