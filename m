Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B662D6A8249
	for <lists+linux-pci@lfdr.de>; Thu,  2 Mar 2023 13:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjCBMdR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Mar 2023 07:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCBMdP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Mar 2023 07:33:15 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF50ADBF2
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 04:33:11 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230302123309epoutp018403339c38d21de693c38399c2d4dbc2~Imi9Nljq50934409344epoutp01n
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 12:33:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230302123309epoutp018403339c38d21de693c38399c2d4dbc2~Imi9Nljq50934409344epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677760389;
        bh=reWe3PGRrLym5LioBfyhzFhQYKN/v9JScAghpZjyx4U=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ujwQH0hR9nLj70MfUpVZyvZlJFK5srKPmFMqlMILh/p1aZwOJsK1mn9mD5IWtvxPx
         Kr1DAFC9VitkRW1hxV0TZaSjfbLUMbMbKp+7Jn/k8s1t5ZJ07VFbJWN4glknMP3lZw
         544Umhol0XqBvCJvdKRa5dH4BgELv1og9yYa8+lI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230302123308epcas5p3e6c6a84b3af84c981e9e79ea9b5d43ee~Imi8kDZSv0316203162epcas5p3R;
        Thu,  2 Mar 2023 12:33:08 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PS9Vq2V2Cz4x9Pr; Thu,  2 Mar
        2023 12:33:07 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.FC.55678.38790046; Thu,  2 Mar 2023 21:33:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230302123306epcas5p188a65a10f2db8e957df81e1d5bf68edf~Imi6q3JhD1578815788epcas5p1j;
        Thu,  2 Mar 2023 12:33:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302123306epsmtrp16796406596706ac0cd13c990734ad1f0~Imi6p3B661843118431epsmtrp1Q;
        Thu,  2 Mar 2023 12:33:06 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-7b-640097832f78
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.B2.31821.28790046; Thu,  2 Mar 2023 21:33:06 +0900 (KST)
Received: from pankajdubey02 (unknown [107.122.12.6]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230302123302epsmtip20d48b2a478599bb36c12db5973f0428d~Imi3YZskG2681526815epsmtip2A;
        Thu,  2 Mar 2023 12:33:02 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Shradha Todi'" <shradha.t@samsung.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <alim.akhtar@samsung.com>,
        <jingoohan1@gmail.com>, <Sergey.Semin@baikalelectronics.ru>,
        <lukas.bulwahn@gmail.com>, <hongxing.zhu@nxp.com>,
        <tglx@linutronix.de>, <m.szyprowski@samsung.com>,
        <jh80.chung@samsung.co>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3777f2b1-1319-ec63-7a32-0e9032bf1933@linaro.org>
Subject: RE: [PATCH 09/16] PCI: samsung: Make common appl readl/writel
 functions
Date:   Thu, 2 Mar 2023 18:03:01 +0530
Message-ID: <146401d94d03$23a0ed50$6ae2c7f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHB3D0FgV9/Br8Y35oSVRdB1anKHwL0NE+vAnmLhf4Bs+sFhK7dQEXw
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1AbVRhlH9kNxbQroFwYqphSsThAQgMuTkJVOnStdAaw+IMfxZSsBAmb
        kE1QyjBGQGgpacEXkAKlDlAeFWlASoEi8hiKYFpLyw8sQlq0vIahoJJCZzDJovLvfN895zv3
        3DsfH3HfxHz4qYyO1jJylRDbhXYMHAgIyitzUYie1BLkTHUHRtbmKsmLgxYeaeqogsjHmxaU
        bPizAifPzVkR8sbi9zhpKN7kkeaHEzxyvKsSI3+uHsbI8lu9MJn/NB8l84cKUfLbwSmc3Orp
        xMmnZSsoaRzIIdvMXyFveFJL5nWcum6awqkas54yN53BqPsTPRi1bLHg1OzdMphqq/2Eurrc
        CVPfGB5j1Ln2JohaM78Q+0ximlRJyxW01o9mktWKVCZFJnzn3aSopLBwkThIHEG+JvRj5Om0
        THg4JjYoOlVljyn0y5Sr9PZWrJxlhSGRUq1ar6P9lGpWJxPSGoVKI9EEs/J0Vs+kBDO07nWx
        SBQaZie+n6asXrkKa2b2fDw2Z0EN0JCgCHLlA0ICfmxcxIqgXXx3ohsCC0YzwhWrELhVubFd
        rEFg6t6WncZ3SsZ61Vy/CwK/Fl/kccUCBIpsd3iOuRgRAiy2aueBJ9GHAOvtOmeBEC0QmL1k
        hB0sVyIS5BoLnNiDiAcFS5OIA6OEP2huqHJOEhARYLS5GOfws2CkYhZ1YIR4FdRfWkS4FH7g
        ye/1Tr4nEQ0qeiYxjuMF5ocGcYcxIC67gqURG8wJDoPWyYlt7AEWhttxDvuA+fMFOJczBtR1
        U1xbB1qL61AOHwJ9dytRBwUhDoDvukI4q93AuDkLc0oBOF3gzrFfBuuPxrZv6QuseXXbphS4
        s9UOlUAvmXYEM+0IZtoRwPS/WQ2ENkHetIZNT6HZME0oQ3/034cnq9PNkHMLAo92QtaZleB+
        COZD/RDgI0JPQbbBReEuUMizTtFadZJWr6LZfijM/tqliM9zyWr7GjG6JLEkQiQJDw+XRBwM
        Fwu9BAGykWR3IkWuo9NoWkNr/9XBfFcfA9ywdmKOmQm45n8ocsK/vaT3xYzWv/cdL8Jiz59l
        FNKuL+vj2GifuKNKW8Vbmo3+n9wkCTLJ6HxoVHxVMH7lg0mmlPewKeZG3mdrzR6e1sTsVypC
        sGn+qHfvke7l3vHM1f3SFkS6YVSEANGR8S92n8xpVKy3+J86Nv12at91l1/WCv+KsMV7ZdMN
        jVvXsk+XXrAFXjj5aG/z7WjkwUF5bqxGdQw+iyLz3j+UfJ24vzZBNvXA7XLOsMhXXziwd9pb
        OrKynp2xIIv5XH3iuPTeapRJch+1/hZcI8vcc+UmW84+35lxcyghq3bfmU/nrKL4PwTvxY0b
        NsqXp99ccWvL6vuwxFeIskq5OBDRsvJ/ADSkgPyOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xSYRjHezmHc44UeUKKV+02VnPDpdltbxfNdbHT1pbVamlXkpO6FAnQ
        stYksouopStnslIrRqTSFoZRkR+ElmaRFTPXsovmpeVKw7LStIC1+e337H95ng8PhQk68RAq
        Va5mlXJpmpjg4XUO8ax52tIJsvlWuxC9L68jkEGbgiqcLi7S110GaGDYhSPTYBmJzvZ+wNCD
        z1YSaQqGucjS2cpFL+9dItDT8kcEuvisnoNyR3JxlPvwNI7MznYSjdltJBop7cdRoeMYqrWU
        YLFCps8yRDJ39e0kU2nJZCxVeQTzptVOMF9cLpL56C7lMLWGHObWFxuHuaoZIJizt6sA47HM
        jJ+UyFshY9NSs1hlZMxeXkpd21tSYQg8XPg6TAPy+DpAUZBeBJ/UZ+hAACWgbQD2WAkvQ3o6
        PF9t4vo5CN4Y7SF1gPfP0wvgt942n4mgI6HrZznXKwjpFgz2uJpx74DRFgA9RjPmj/QB6DYc
        J72RADoGagtPcbwcRMfD68+tvh04PQdWmy77mE8vhc3VBaSfp8Cmso+4lzE6HBZ+OAn+s/HK
        Z8x/32z4q8voywrpOFhmf034PSL46aGTLAJB+nFV+nFV+nFV+nGRSoBXgWBWoUpPTldFKRbI
        2UMRKmm6KlOeHJGUkW4Bvj+QSGzAXtUf0QA4FGgAkMLEQv5RzQSZgC+TZh9hlRl7lJlprKoB
        hFK4WMRv0TXtEdDJUjV7gGUVrPK/yqECQjQccfHOrb8WDZ2gwjHPn9Gp54ZiRC02eWN96Qze
        mmVkydhi5QFwbd8zR7M+QX3/XaRg+9TcddmrtU0KY/jy4pyOHbuTKsScGe18+KOvNtRtDhmb
        maBr+bpsOn7j5MTvWzw/+9faIuPDlsRWFJ2Llnc5bSZPXuLvGnfC4MqogfItxXbTts3zYsPu
        dJ6p0U4bzFarsjKfT75TG15R4HBeeOU6E7xdnxO3a6vbdZ4baDCWiNJWbZxbIu4M7F6/oc0B
        c8biokesC0KfZEnyu/tT2q/JDebKphFyNH+25HG0XXpvYGGwc9N+9U1z/YvJT7s+5eXjwdmh
        mzt2dnfskokSGw/WDItxVYo0SoIpVdK/dMR6nHYDAAA=
X-CMS-MailID: 20230302123306epcas5p188a65a10f2db8e957df81e1d5bf68edf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121440epcas5p46db82a141c3e2664cff4b290b49c3938
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121440epcas5p46db82a141c3e2664cff4b290b49c3938@epcas5p4.samsung.com>
        <20230214121333.1837-10-shradha.t@samsung.com>
        <3777f2b1-1319-ec63-7a32-0e9032bf1933@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: Thursday, February 16, 2023 4:38 PM
> To: Shradha Todi <shradha.t=40samsung.com>; lpieralisi=40kernel.org;
> kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com;
> krzysztof.kozlowski+dt=40linaro.org; alim.akhtar=40samsung.com;
> jingoohan1=40gmail.com; Sergey.Semin=40baikalelectronics.ru;
> lukas.bulwahn=40gmail.com; hongxing.zhu=40nxp.com; tglx=40linutronix.de;
> m.szyprowski=40samsung.com; jh80.chung=40samsung.co;
> pankaj.dubey=40samsung.com
> Cc: linux-pci=40vger.kernel.org; devicetree=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.org; linux-
> kernel=40vger.kernel.org
> Subject: Re: =5BPATCH 09/16=5D PCI: samsung: Make common appl readl/write=
l
> functions
>=20
> On 14/02/2023 13:13, Shradha Todi wrote:
> > Common application logic register read and write functions used for
> > better readability.
> >
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pci-samsung.c =7C 54
> > ++++++++++++------------
> >  1 file changed, 27 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-samsung.c
> > b/drivers/pci/controller/dwc/pci-samsung.c
> > index be0177fcd763..e6e2a8ab4403 100644
> > --- a/drivers/pci/controller/dwc/pci-samsung.c
> > +++ b/drivers/pci/controller/dwc/pci-samsung.c
> > =40=40 -79,63 +79,63 =40=40 static void exynos_pcie_deinit_clk_resource=
s(struct
> samsung_pcie *sp)
> >  	clk_bulk_disable_unprepare(sp->clk_cnt, sp->clks);  =7D
> >
> > -static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
> > +static void samsung_pcie_appl_writel(struct samsung_pcie *sp, u32
> > +val, u32 reg)
>=20
> No for renaming - same reason as for previous patch.
>=20

I have tried to justify our rational behind this in previous patch, I hope =
that makes sense.

>=20
> Best regards,
> Krzysztof


