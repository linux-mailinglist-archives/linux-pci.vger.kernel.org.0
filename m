Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A0D6A90E8
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 07:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCCGYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 01:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCCGYW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 01:24:22 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548D914996
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 22:24:20 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230303062418epoutp0154e4614cb90fcf2387126818a954d4eb~I1KNA615h2445624456epoutp01a
        for <linux-pci@vger.kernel.org>; Fri,  3 Mar 2023 06:24:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230303062418epoutp0154e4614cb90fcf2387126818a954d4eb~I1KNA615h2445624456epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677824658;
        bh=WpZeTKaH+7VDz1GPOH4jteG9+Gqhoom8RDIbBA11BZ8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=eu/5DK9dkW4apVJ5DWbIGYpl2vKeCBBy9vhNtOxIzgw3MfRgbi7J4a0URcXFW8MRv
         E4JUXEVLCCkP49ckFxTEmg/auVnxaeYnet5mOGGTgERKeAhge+8/kiWSBk3oO8UbVq
         aOCIVn1l6rHmGmdViuYMBS9o2NXeCGKo/qEI0zYQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230303062417epcas5p21f2b2625c94832bee36cbda609700fc0~I1KLqGa8Q1275712757epcas5p2a;
        Fri,  3 Mar 2023 06:24:17 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PSdGl4rk8z4x9QC; Fri,  3 Mar
        2023 06:24:15 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.36.06765.F8291046; Fri,  3 Mar 2023 15:24:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230302125139epcas5p45856f8efaae1a3df0fba5b8cf97e0db0~ImzHBO03m2384823848epcas5p45;
        Thu,  2 Mar 2023 12:51:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302125139epsmtrp1af2c9e464fe0d8b2b9a03e6daadafa65~ImzG_8WA42956129561epsmtrp1j;
        Thu,  2 Mar 2023 12:51:39 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-ad-6401928f786c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.63.31821.BDB90046; Thu,  2 Mar 2023 21:51:39 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230302125136epsmtip1d3cd40f3bee7898c5395005274e00eef~ImzEd8w7K3169131691epsmtip1n;
        Thu,  2 Mar 2023 12:51:36 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <alim.akhtar@samsung.com>,
        <jingoohan1@gmail.com>, <Sergey.Semin@baikalelectronics.ru>,
        <lukas.bulwahn@gmail.com>, <hongxing.zhu@nxp.com>,
        <tglx@linutronix.de>, <m.szyprowski@samsung.com>,
        <jh80.chung@samsung.co>, <pankaj.dubey@samsung.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20230214191734.GA23567-robh@kernel.org>
Subject: RE: [PATCH 10/16] dt-bindings: PCI: Add phy-names as required
 property
Date:   Thu, 2 Mar 2023 18:21:35 +0530
Message-ID: <139401d94d05$baeefce0$30ccf6a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHB3D0FgV9/Br8Y35oSVRdB1anKHwD2M2WLAWiR33oB7PHP067z9F5w
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxjGd3tvb2+RLtfCwoENbC6KgQxope0uBGQRY25WzWBzJlu2QEPv
        WkJpu95W9pl1yhwCE5WPQmGAhgEjUWORr8rYKCDDxJqNL2HCGOCChjEQhtOirOWWjf9+57zP
        e573OScHg4WP0BAsS2eijTqllkD9kLbeyKjo4vOQSvybdTc5XdOGkvUnNGRtn4tL2tq+gchl
        twshm1YreeSZ+d9h0lLk5pL22VEuOeSoRslbNQMoWXG7m0PmrechZF7/Vwh5qW+SR15sXeWR
        G10dPHLduoSQLfYy+NUAasH+iEd12iZ5VJ3dTNmbT6PU3dEulFp0uXjU3LCVQ7XUf05dXezg
        UBctyyh15lozRK3Yw1L938lO1NBKFW0U0bpMvSpLp04iFG+mp6TL5GJJtCSefIUQ6ZQ5dBJx
        8HBq9KEsrSciITqu1Jo9W6lKhiFi9yca9WYTLdLoGVMSQRtUWoPUEMMocxizTh2jo00JErF4
        n8wjzMjWtG/4G/r8PnxS/pBrge5jBRAfA7gU1E/kcwogP0yIX4fAs5FaiF08hEDJF2NcdrEC
        gW73GrrVcqpuAWELDgiMzy5zvAUhPg+BeRfPyyj+MpgbXoe9HIjvASds05sNMF6MANf3tYi3
        wMdloLS+cFMUgKeB3qlLXC8j+G4w2zCweZAAjwdXF8t8vBMMVs5t9sL4LtD+ZzXMTiQCj+81
        cFmzQ6DA2Y6ymiDQ/7gI9hoDvJYPhgqXfREOgrvDoxyWA8CDgWs8lkPA/eJTPlaD71oqfAZa
        sNZS79Mngx+Hqz1DYB6DSHDFEctuh4Kym5c5rO/z4Gv3nE8uAB01WxwOVp92ISwHg5obQ9yz
        EGHbFs22LZptWwTb/251ENIMBdMGJkdNMzJDnI7O/e/BM/U5dmjzB0QpOqCZ6aUYJ8TBICcE
        MJgIFHxieU4lFKiUH31MG/XpRrOWZpyQzHPf5+CQFzL1ni+kM6VLpPFiqVwul8bHySVEkGBv
        0mCmEFcrTXQ2TRto41YfB+OHWDiH5YmOVkfs+KpzbNa9ln9n1d41MflPQ2JQSkqO+mhlpP9f
        igfRCUd2NckDb95pC2i8nGEt+SXhJMOtcjf2R34qpfaoOkuPRTXfyi2oehrOe2Nj/LrtdnLE
        jYjyqmhNgvrtd2cqVka6w97vV/1R1v1saqTQ//Xy2LwDaRVLeZZv+2wTgveOnE7Yu4ghsnjz
        k4m3gGVsoxeKeKk07qdWv4gC62tVJ8lqa1r5AZUxsiVsp0QTfmWmcl9uT2Py2t/JC6FYydn1
        1K5Rx687Mi4ErzhFRxmkv5vf89mx827xBzPG9AuKuuR8QZ1wYuPLF+Ge/fccO374uTNkKpFf
        XTR4HGkShSoIhNEoJVGwkVH+C+H5zzCKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCSnO7t2QwpBrM2sVg8mLeNzWJJU4bF
        /CPnWC1mbZvLaPHx9zkWixVfZrJb9L14yGzR0POb1WLT42usFpd3zWGzODvvOJvFjPP7mCxa
        /rSwWLQcbWexWHvkLrvFoq1f2C3+79nBbvFn+gcWi82bpjI7CHu82fSd3WPnrLvsHgs2lXps
        WtXJ5nHn2h42j3fnzrF7PLkynclj85J6j43vdjB5LGr4yObRt2UVo8fnTXIBPFFcNimpOZll
        qUX6dglcGdv/8xQc4ar4Ne0TawPjS44uRk4OCQETibYFb1i6GLk4hAR2MEpcubmTBSIhKfH5
        4jomCFtYYuW/5+wQRc8YJbZ0djKCJNgEdCSeXPnDDGKLCKhKNM16ADaJWWAxi8TH/x1gRUIC
        jxklLr4pB7E5BUwlpizpBmrg4BAW8Je42MUHEmYRUJF4vOw4O4jNK2ApsfHdVChbUOLkzCcs
        IOXMAnoSbRvBJjILyEtsfzuHGeI2BYmfT5exQpzgJtF1aDsbRI24xNGfPcwTGIVnIZk0C2HS
        LCSTZiHpWMDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzgBaGntYNyz6oPeIUYm
        DsZDjBIczEoivNUNDClCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2C
        yTJxcEo1MHHfKVV5lLdRydFuTf6aMya7Kt0Yb/zhufMm5bDtBnZhI+cgnh5796wlVfdPOS47
        a6pvfkOzx2LVocXNtsarZn2N3XwtI7e8/+fmnDlT+lUsqrp+6Z5cqy/XY/Jw2svPe/8dyC52
        6m57/tGXd+ubV+edJmnO8AsM/LROdJ0yj7DtqY0Tu14tvuoTVyTpqRz5obJqOc9U3r6J/icP
        q0duLn+fcDQ3NPwsE7NVt3Th1fK6241fbGT9rv/w97z3o27BvYMWj/fdCl7uUbf33Ue+8wY3
        LLid4uYvenRhRmSLrIHdL66bJSsLOwy9XryTe7JY70WJSKl2+spTjnuCJvp8uq91XGKOkaWm
        uu+GY04T+ZVYijMSDbWYi4oTAetuifhvAwAA
X-CMS-MailID: 20230302125139epcas5p45856f8efaae1a3df0fba5b8cf97e0db0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121444epcas5p16c5f7665fc9dee78cd427d976114e4f1
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121444epcas5p16c5f7665fc9dee78cd427d976114e4f1@epcas5p1.samsung.com>
        <20230214121333.1837-11-shradha.t@samsung.com>
        <20230214191734.GA23567-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: 15 February 2023 00:48
> To: Shradha Todi <shradha.t@samsung.com>
> Cc: lpieralisi@kernel.org; kw@linux.com; bhelgaas@google.com;
> krzysztof.kozlowski+dt@linaro.org; alim.akhtar@samsung.com;
> jingoohan1@gmail.com; Sergey.Semin@baikalelectronics.ru;
> lukas.bulwahn@gmail.com; hongxing.zhu@nxp.com; tglx@linutronix.de;
> m.szyprowski@samsung.com; jh80.chung@samsung.co;
> pankaj.dubey@samsung.com; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 10/16] dt-bindings: PCI: Add phy-names as required
> property
> 
> On Tue, Feb 14, 2023 at 05:43:27PM +0530, Shradha Todi wrote:
> > To replace devm_of_phy_get with devm_phy_get to get the PHY pointer
> > using non DT version, we need to add phy-names property in DT and make
> > it a required property with const value.
> 
> Also an ABI break.
> 
> And unnecessary. You don't need a name with a single entry. Pretty sure I
> fixed that for phy_get at some point.
> 

Thanks, I got your point. I will drop this. As of now we have only single
PHYs for Samsung and it can be handled
via phy_get API without a name as you highlighted.

Shradha

> Rob

