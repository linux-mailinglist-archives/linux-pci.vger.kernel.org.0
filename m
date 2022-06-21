Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8C552C73
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347327AbiFUH4l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 03:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347674AbiFUH4k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 03:56:40 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B24248DA
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 00:56:39 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220621075637epoutp023982dc616f38bd38e33447d47e11fb0f~6k7ACl0W81250312503epoutp02F
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 07:56:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220621075637epoutp023982dc616f38bd38e33447d47e11fb0f~6k7ACl0W81250312503epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655798197;
        bh=qMkIU/60yigSbDip1bHSim25RSYjPC0FSsBXInxoocM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=o7R+wTJBc5EhObtTVKXwC4+1x0VG19r6NWLBhmL3dKXnF3i+XF+Vg1cKGG/U5Wdn/
         ibX9od4PrX/0W5NdPqFXinmCWq0hGiS1eeJHoknqNhnRsbcYtMZl1pdGMXIUkICAmx
         ewkBhzjoKd4zW7md2LErCXt20IIBiya80ZUEWH4I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220621075635epcas2p153d2731cc2986f491bb6d4accaf87ee7~6k6_7SzU62117621176epcas2p1T;
        Tue, 21 Jun 2022 07:56:35 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LRzNz4RbGz4x9Pp; Tue, 21 Jun
        2022 07:56:35 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-5d-62b179b32e90
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.39.09642.3B971B26; Tue, 21 Jun 2022 16:56:35 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v3 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>
CC:     Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <e3411d6c-ec64-f20e-4c58-13245fe255b5@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220621075635epcms2p79d73dfb24d1d8d49af7467db48598e6f@epcms2p7>
Date:   Tue, 21 Jun 2022 16:56:35 +0900
X-CMS-MailID: 20220621075635epcms2p79d73dfb24d1d8d49af7467db48598e6f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmqe7myo1JBmsPyVksacqweHlI02L+
        kXOsFrtnLGeymDn1DLPF80OzmC0+tahaXHjaw2bxctY9Novz5zewWzT0/Ga1OPLmI7PF/uMr
        mSwu75rDZnF23nE2iwmrvrFYvPn9gt3i3OJMi9a9R9gtdt45wWzxa+sfJgdRjzXz1jB6XF8X
        4LFgU6nHplWdbB5Prkxn8ti8pN6jb8sqRo/jN7YzeXzeJBfAGZVtk5GamJJapJCal5yfkpmX
        bqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0mZJCWWJOKVAoILG4WEnfzqYov7Qk
        VSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO2PTy27mgu1cFQvOTWdsYJzM
        1cXIySEhYCLRvuATaxcjF4eQwA5Gid2PDjJ2MXJw8AoISvzdIQxSIyzgJfGmtYkRxBYSUJLY
        sWYeM0RcX+L6im5WEJtNQFfi3+KXbCBzRARmsUks+bqUCcRhFljAKLH/9z5GiG28EjPan7JA
        2NIS25dvBYtzCthJHD06gx0iriHxY1kvM4QtKnFz9Vt2GPv9sflQc0QkWu+dhaoRlHjwczdU
        XEpiwZNDrBB2tcT+v7+ZIOwGRon++6kgj0kAXb3jujFImFfAV6J/3zewchYBVYmzL09BneYi
        0ftuCRuIzSygLbFs4WtmkFZmAU2J9bv0IaYoSxy5xQLzVMPG3+zobGYBPomOw3/h4jvmPYE6
        Rk1i3sqdzBMYlWchAnoWkl2zEHYtYGRexSiWWlCcm55abFRgDI/b5PzcTYzgNK7lvoNxxtsP
        eocYmTgYDzFKcDArifDacG9IEuJNSaysSi3Kjy8qzUktPsRoCvTlRGYp0eR8YCbJK4k3NLE0
        MDEzMzQ3MjUwVxLn9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXAJLhlg+rju0+m2H6UOz5H0/Xb
        xLNemg6zCnUPcuv82N0k1uHMsC936umcDIvohSasF++2r5H1bp6Y+HZNhPi2VRw5ajuvqX27
        dsoqTSC39PH9M7OiV/F+kytTf6lWOddGcfuh/du+L2Jaseh6YtsOb56f77qO6Nosn2nd+8bC
        hqU6769f2OxVrCnrPhjKnzkyXejUtoDzff23ZsZ0LT9Znf4sdjXTw91RnHO5r8aZ1k4vN/wl
        H1ZuslmM2/Xyzp1BazO/nDkXtvX0kTA2tdL/HoV3dcJtZqm+M1S6+dN34vmmSReMDabaKkjv
        XZq0XedJ/OfQe3HzsqZ1Pz/EHdWZqi4j9LRhx2ZtV3vZjX+WzFdiKc5INNRiLipOBACKymWD
        bAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7
References: <e3411d6c-ec64-f20e-4c58-13245fe255b5@kernel.org>
        <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
        <20220614013042epcms2p36f88b7eb7f879fefb2f3fbd4548ad705@epcms2p3>
        <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On=C2=A020/06/2022=C2=A017:35,=C2=A0Krzysztof=20Kozlowski=20wrote:=0D=0A>=
=20On=C2=A014/06/2022=C2=A003:30,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A>=
>=C2=A0Add=C2=A0support=C2=A0Axis,=C2=A0ARTPEC-8=C2=A0SoC.=0D=0A>>=C2=A0ART=
PEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platform=C2=A0of=C2=A0Axis=C2=A0Commun=
ications.=0D=0A>>=C2=A0=0D=0A>=20=0D=0A>=20(...)=0D=0A>=20=0D=0A>>=C2=A0+=
=0D=0A>>=C2=A0+enum=C2=A0artpec8_pcie_isolation=C2=A0=7B=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PCIE_CLEAR_ISOLATION=C2=A0=3D=
=C2=A00,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PCIE=
_SET_ISOLATION=C2=A0=3D=C2=A01=0D=0A>>=C2=A0+=7D;=0D=0A>>=C2=A0+=0D=0A>>=C2=
=A0+enum=C2=A0artpec8_pcie_reg_bit=C2=A0=7B=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PCIE_REG_BIT_LOW=C2=A0=3D=C2=A00,=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PCIE_REG_BIT_HIGH=C2=
=A0=3D=C2=A01=0D=0A>>=C2=A0+=7D;=0D=0A>=20=0D=0A>=20Remove=C2=A0this=C2=A0e=
num.=C2=A0This=C2=A0is=C2=A0redefinition=C2=A0of=C2=A0true/false=C2=A0or=C2=
=A01/0.=0D=0A>=20=0D=0A>=20Best=C2=A0regards,=0D=0A>=20Krzysztof=0D=0A=0D=
=0Aok,=20i=20will=20change=20the=20above=20enum=20types=20to=20boolean.=0D=
=0A=0D=0AThank=20you=20for=20kindness=20reivew.=0D=0A=0D=0ABest=20regards,=
=0D=0AWangseok=20Lee
