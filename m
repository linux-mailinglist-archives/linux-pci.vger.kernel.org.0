Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C94CB33F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 01:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiCCAQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 19:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiCCAQN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 19:16:13 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED4D1275CD
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 16:15:28 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220302225640epoutp02462da57d46567b995bc5e91a591c5f8a~YsmKf9rw-1310613106epoutp02P
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 22:56:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220302225640epoutp02462da57d46567b995bc5e91a591c5f8a~YsmKf9rw-1310613106epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646261800;
        bh=3iWbbqBJOFzWAOvgnsU3hKkcSQAKwiWkLuhIlSq681Y=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=uwRvZyP+4WCCQvaNmDPiejEK48NkRC4SHMONuIGqi1NoWEgdUtzlfq9+QY8xI5R7M
         9+xI4/K/hoHMeL35g7raF9T0/qlYRSWYOOE0VhQ+LAYXpYo9WAvtZQNH5cEsFZhad/
         8Dtp32qiEU50+zaZ1sAJXBcQqxJQcEOnsga1Qh1k=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220302225639epcas1p2a85a59e0acf2beadd05e27743e5cb7c9~YsmJ3g_AJ2430124301epcas1p2h;
        Wed,  2 Mar 2022 22:56:39 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.241]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4K88ck1y66z4x9Px; Wed,  2 Mar
        2022 22:56:38 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.E4.09592.626FF126; Thu,  3 Mar 2022 07:56:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220302225637epcas1p11a0d9f404de6dc2701121ffbc7d412e4~YsmIDhjBt1098510985epcas1p1b;
        Wed,  2 Mar 2022 22:56:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220302225637epsmtrp2e5254885b64a554a7d19bc991a04ece6~YsmICsmnX0052300523epsmtrp2Q;
        Wed,  2 Mar 2022 22:56:37 +0000 (GMT)
X-AuditID: b6c32a37-2a5ff70000002578-00-621ff626ad30
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.74.29871.526FF126; Thu,  3 Mar 2022 07:56:37 +0900 (KST)
Received: from yj84jang02 (unknown [10.88.97.211]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220302225637epsmtip1abad9f4216e10a5d6043de269b6cd3e7~YsmHzktTf0949609496epsmtip1D;
        Wed,  2 Mar 2022 22:56:37 +0000 (GMT)
From:   =?utf-8?B?7J6l7JiB7KeEL1RWIFMvVyBMYWIoVkQpL1N0YWZmIEVuZ2luZWU=?=
         =?utf-8?B?ci/sgrzshLHsoITsnpA=?= <yj84.jang@samsung.com>
To:     "'Bjorn Helgaas'" <helgaas@kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Pavel Machek'" <pavel@ucw.cz>,
        "'Len Brown'" <len.brown@intel.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <js07.lee@samsung.com>
In-Reply-To: <20220302201600.GA746065@bhelgaas>
Subject: RE: [PATCH] PM: Add device name to suspend_report_result()
Date:   Thu, 3 Mar 2022 07:56:37 +0900
Message-ID: <044701d82e88$c5edb6f0$51c924d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEynvdJh8FuJQ7CWAlJZtNNGRQBBQHeIvO4rejfgPA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmga7aN/kkg8OLOCyWNGVYNC9ez2bx
        6sxaNotHN3+zWsyaspfJYvm+fkaLy7vmsFmcnXeczeJz7xFGi0XLWpkt7p46ymYx98tUZgce
        jwWbSj0W73nJ5LFpVSebx/65a9g9+rasYvRYsfo7u8fnTXIB7FHZNhmpiSmpRQqpecn5KZl5
        6bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAdyoplCXmlAKFAhKLi5X07WyK8ktL
        UhUy8otLbJVSC1JyCswK9IoTc4tL89L18lJLrAwNDIxMgQoTsjMmNneyFRxSrXg3cy5TA+N6
        lS5GTg4JAROJd00vmbsYuTiEBHYwShyfupgVJCEk8IlR4s4fa4jEN0aJ+St2ssF0nH/znQmi
        aC+jxI9bTBBFzxkl3r2ewgiSYBNoZJT4810BxBYRSJRYO7+ZBaSIWeASk8T1S1vAijgF9CXO
        n+0AmyQs4Cyxd98RFhCbRUBF4sDVM8wgNq+ApcTiNSfZIWxBiZMzn4DVMAtoSyxb+JoZ4iIF
        iZ9Pl7FCLLOSaFnSB1UjIjG7sw2q5giHxMZzYRC2i0TPwrusELawxKvjW9ghbCmJz+/2Qn2Z
        LjHx8VuoeIHE38dLoOYYS7x7uxbI5gCarymxfpc+RFhRYufvuYwQa/kk3n3tYQUpkRDgleho
        E4IoUZZ4fH411HRJifW/9zNNYFSaheSxWUgem4XkgVkIyxYwsqxiFEstKM5NTy02LDCGx3Vy
        fu4mRnAK1jLfwTjt7Qe9Q4xMHIyHGCU4mJVEeMWt5ZOEeFMSK6tSi/Lji0pzUosPMZoCg3oi
        s5Rocj4wC+SVxBuaWBqYmBmZWBhbGpspifOumnY6UUggPbEkNTs1tSC1CKaPiYNTqoHpunid
        Q/RF7nWGV99tnsnyTfbFPf80zu8CC7cySl039FwoPa/9wDXBd11ZBf6+Z3f2ZvHo7G/w3Kln
        MO9F/S5XaZOCVZZW/N8ZH69LCM8/97fBsPQgf0KWaPCZk3JL/Lz3ap7RYJ+yil3tS2SNzP3Y
        F5rLt3GvWrHrrnxD1sYSv0wP2ReqDs+XJR40YjlpfuLlJt2ujRt4nkWl9Hg6HL1RvvZ1XdI1
        Jo0jk76VLZ70TW+n5k6BdwJuAR8mZ31V00jbfyp9iahyZLTq9qN/8+VlHc6I39l/kOPutpmB
        +mmVGRLG1zZI+DbM/HwjvHjLiZWH7A6VT2zizVy0q7r2ivIrXrkPapO5jP+eFL2b6y+txFKc
        kWioxVxUnAgAG6TXeEoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSnK7qN/kkg28PdCyWNGVYNC9ez2bx
        6sxaNotHN3+zWsyaspfJYvm+fkaLy7vmsFmcnXeczeJz7xFGi0XLWpkt7p46ymYx98tUZgce
        jwWbSj0W73nJ5LFpVSebx/65a9g9+rasYvRYsfo7u8fnTXIB7FFcNimpOZllqUX6dglcGSv2
        32EsWCBV0fxrE1sD40zRLkZODgkBE4nzb74zdTFycQgJ7GaUeD7lNyNEQlLi66fPbF2MHEC2
        sMThw8UQNU8ZJTbNu8cMUsMm0Mgo8ee7AogtIpAo0ft1BguIzSxwi0ni7yFniIYGRolVRzeA
        JTgF9CXOn+1gArGFBZwl9u47AhZnEVCROHD1DNhQXgFLicVrTrJD2IISJ2c+gRqqLfH05lM4
        e9nC18wQhypI/Hy6jBXiCCuJliV9UDUiErM725gnMArPQjJqFpJRs5CMmoWkZQEjyypGydSC
        4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOCI1NLcwbh91Qe9Q4xMHIyHGCU4mJVEeMWt5ZOE
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYNoV9uXFt/Uy
        RUovPXVa5Hyip3hEeO3teT/JKa7xmpKy5nLrIKEf9qZ81idKYm/dND7y8zvTphKPG7Nj425m
        8E+5sdaoN/NS0fyvqT+nff1k3HKhwnP1tve7zefZOO3e7yXsqKK4ou05y+wda6P65Eyr3uvO
        SRR0lT8s67luXSXjje2687ftF5zR8LJme7f+se5H/6aLR06xM4ot8mIp+lfxRnuXwR6Jxztb
        fD/UXLho/6rpXeVB7Z9zwo48Snjv3dfp+1/pyQfj0kwldsfABxOce26kHf69SPbxWSUjL9tr
        Xlm7Xh34zXVr7f7sB11n9d8lcGrOOTFn2TtbL9UVOVyrO2vMczgY+5eYcAQ92qbEUpyRaKjF
        XFScCADf4E/lNwMAAA==
X-CMS-MailID: 20220302225637epcas1p11a0d9f404de6dc2701121ffbc7d412e4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220302201609epcas1p4d2c0b15e8915f359e6744e21c27022a0
References: <CGME20220302201609epcas1p4d2c0b15e8915f359e6744e21c27022a0@epcas1p4.samsung.com>
        <20220302201600.GA746065@bhelgaas>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Bjorn Helgaas <helgaas=40kernel.org>
> Sent: Thursday, March 3, 2022 5:16 AM
> To: 'Greg Kroah-Hartman' <gregkh=40linuxfoundation.org>
> Cc: =EF=BF=BD=E5=BF=B5=EF=BF=BD=EF=BF=BD/TV=20S/W=20Lab(VD)/Staff=20Engin=
eer/=EF=BF=BD=EF=BC=BA=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=20<yj84.jang=40s=
amsung.com>;=0D=0A>=20'Rafael=20J.=20Wysocki'=20<rafael=40kernel.org>;=20'P=
avel=20Machek'=20<pavel=40ucw.cz>;=0D=0A>=20'Len=20Brown'=20<len.brown=40in=
tel.com>;=20'Bjorn=20Helgaas'=20<bhelgaas=40google.com>;=0D=0A>=20linux-pm=
=40vger.kernel.org;=20linux-kernel=40vger.kernel.org;=20linux-=0D=0A>=20pci=
=40vger.kernel.org;=20linux-acpi=40vger.kernel.org;=20linux-usb=40vger.kern=
el.org;=0D=0A>=20js07.lee=40samsung.com=0D=0A>=20Subject:=20Re:=20=5BPATCH=
=5D=20PM:=20Add=20device=20name=20to=20suspend_report_result()=0D=0A>=20=0D=
=0A>=20On=20Wed,=20Mar=2002,=202022=20at=2003:52:51PM=20+0100,=20'Greg=20Kr=
oah-Hartman'=20wrote:=0D=0A>=20>=20On=20Wed,=20Mar=2002,=202022=20at=2008:0=
0:14PM=20+0900,=20=20=E5=BF=B5=20=20/TV=20S/W=20Lab(VD)/Staff=0D=0A>=20Engi=
neer/=20=EF=BC=BA=20=20=20=20=20wrote:=0D=0A>=20>=20>=20>=20-----Original=
=20Message-----=0D=0A>=20>=20>=20>=20From:=20Greg=20Kroah-Hartman=20<gregkh=
=40linuxfoundation.org>=0D=0A>=20>=20>=20>=20Sent:=20Wednesday,=20March=202=
,=202022=204:58=20PM=0D=0A>=20>=20>=20>=20To:=20Youngjin=20Jang=20<yj84.jan=
g=40samsung.com>=0D=0A>=20>=20>=20>=20Cc:=20Rafael=20J.=20Wysocki=20<rafael=
=40kernel.org>;=20Pavel=20Machek=0D=0A>=20>=20>=20>=20<pavel=40ucw.cz>;=20L=
en=20Brown=20<len.brown=40intel.com>;=20Bjorn=20Helgaas=0D=0A>=20>=20>=20>=
=20<bhelgaas=40google.com>;=20linux-pm=40vger.kernel.org;=0D=0A>=20>=20>=20=
>=20linux-kernel=40vger.kernel.org;=20linux-=20pci=40vger.kernel.org;=0D=0A=
>=20>=20>=20>=20linux-acpi=40vger.kernel.org;=20linux-=0D=0A>=20>=20>=20usb=
=40vger.kernel.org;=0D=0A>=20>=20>=20>=20js07.lee=40samsung.com=0D=0A>=20>=
=20>=20>=20Subject:=20Re:=20=5BPATCH=5D=20PM:=20Add=20device=20name=20to=0D=
=0A>=20>=20>=20>=20suspend_report_result()=0D=0A>=20>=20>=20>=0D=0A>=20>=20=
>=20>=20On=20Wed,=20Mar=2002,=202022=20at=2003:49:17PM=20+0900,=20Youngjin=
=20Jang=20wrote:=0D=0A>=20>=20>=20>=20>=20From:=20=22yj84.jang=22=20<yj84.j=
ang=40samsung.com>=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20currentl=
y,=20suspend_report_result()=20prints=20only=20function=0D=0A>=20informatio=
n.=0D=0A>=20>=20>=20>=20>=20If=20any=20driver=20uses=20common=20pm=20functi=
on,=20nobody=20knows=20who=20called=0D=0A>=20>=20>=20>=20>=20failed=20funct=
ion=20exactly.=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20So,=20device=
=20information=20is=20needed=20to=20recognize=20specific=20wrong=0D=0A>=20d=
river.=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20e.g.)=0D=0A>=20>=20>=
=20>=20>=20PM:=20dpm_run_callback():=20pm_generic_suspend+0x0/0x48=20return=
s=200=0D=0A>=20>=20>=20>=20>=20PM:=20dpm_run_callback():=20platform_pm_susp=
end+0x0/0x68=20returns=200=0D=0A>=20>=20>=20>=20>=20after=20patch,=0D=0A>=
=20>=20>=20>=20>=20PM:=20dpm_run_callback():=20pm_generic_suspend+0x0/0x48=
=20(amba)=0D=0A>=20>=20>=20>=20>=20returns=200=0D=0A>=20>=20>=20>=20>=20PM:=
=20dpm_run_callback():=20platform_pm_suspend+0x0/0x68=20(armv7-pmu)=0D=0A>=
=20>=20>=20>=20>=20returns=200=0D=0A>=20=0D=0A>=20>=20>=20>=20>=20-=09=09pr=
_err(=22%s():=20%pS=20returns=20%d=5Cn=22,=20function,=20fn,=20ret);=0D=0A>=
=20>=20>=20>=20>=20+=09=09pr_err(=22%s():=20%pS=20(%s)=20returns=20%d=5Cn=
=22,=20function,=20fn,=0D=0A>=20>=20>=20>=20>=20+dev_driver_string(dev),=20=
ret);=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20If=20you=20have=20a=20struct=
=20device,=20please=20use=20dev_err().=0D=0A>=20>=20>=0D=0A>=20>=20>=20I=20=
think=20dev_err()=20is=20nice=20option,=20but=20we=20can=20see=20a=20minor=
=20issue.=0D=0A>=20>=20>=20Prefix=20log=20=22PM:=20=22=20would=20be=20lost,=
=20If=20I=20use=20dev_err()=20in=20this=20context.=0D=0A>=20>=20>=20As=20yo=
u=20know,=20all=20logs=20in=20power=20management=20include=20=22PM=20:=22=
=20prefix.=0D=0A>=20>=0D=0A>=20>=20Why=20does=20that=20matter?=20=20Fix=20t=
hem=20all=20to=20use=20the=20struct=20device=20pointer=0D=0A>=20>=20and=20t=
hen=20they=20will=20be=20properly=20unified=20with=20the=20rest=20of=20the=
=20kernel=20log=0D=0A>=20>=20infrastructure.=0D=0A>=20=0D=0A>=20You=20can=
=20=23define=20dev_fmt=20if=20you=20need=20a=20prefix.=0D=0A=0D=0AI=20teste=
d=20dev_fmt=20before,=20but=20I=20feel=20that=20not=20a=20good=20solution.=
=0D=0ABecause=20the=20readability=20is=20not=20so=20great=20than=20I=20expe=
cted.=0D=0AI=20didn't=20want=20to=20break=20the=20PM=20logging=20rules.=0D=
=0A=0D=0AAnyway,=20I=20got=20you=20guys=20opinion.=0D=0ALet=20me=20try=20se=
cond=20patch=20with=20dev_err().=0D=0A=0D=0A
