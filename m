Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3735E32D9BC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 19:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhCDS4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 13:56:19 -0500
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74]:48816 "EHLO
        mx0a-00364e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235413AbhCDSz4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Mar 2021 13:55:56 -0500
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
        by mx0a-00364e01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124Ifce4007122
        for <linux-pci@vger.kernel.org>; Thu, 4 Mar 2021 13:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type : content-transfer-encoding; s=pps01;
 bh=183dY8jZUE8Orz1CsbavhjLZvg7c7p4ETOhox8xMjwk=;
 b=M+aCsGwGF7wdReDoq7SfWLCVWIRhCrvyz4ERGLwsG6ooElSQsgsCt59I0avxO2IWjbWU
 RL7LHf3Id6C38TZssuul4D33xLY9GS+AqX6GZunrICHvEoIqqtONUQxKFrBYmmz2c4iq
 BY+vXo68bYKCLBPMqFcKIK05FIrO5AQSZaZYU47ZjZ0Zn1onI99A26O/c987xvXy6bO/
 EdIBiMBIusuEfOwAVo7NIzgJyEj3eoQ2pCiHJ5JGMcQBEVC6b+HJId2TEjKqC9DhY1LC
 CnlpRuhyBfFEN90RuNyDcOFYVrZ5iWMo69q4r+Hq1T9VvxQUMued6DsUCx9HB1rtMmS5 tg== 
Received: from sendprdmail20.cc.columbia.edu (sendprdmail20.cc.columbia.edu [128.59.72.22])
        by mx0a-00364e01.pphosted.com with ESMTP id 36yk191gqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 04 Mar 2021 13:55:16 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by sendprdmail20.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 124ItEIL087051
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 4 Mar 2021 13:55:14 -0500
Received: by mail-io1-f69.google.com with SMTP id d4so18532203ioc.16
        for <linux-pci@vger.kernel.org>; Thu, 04 Mar 2021 10:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=183dY8jZUE8Orz1CsbavhjLZvg7c7p4ETOhox8xMjwk=;
        b=Qf9ES/vZIiIfK1X6U9WYkQsuXz2t8zYPSReMJXonROSQo8yoMMWxHFiJf0Kd1V2+u4
         VMC2EycBrO4jqrNKTbYvprZ550hykkkEBoxVQPEKPYuuVvHShNSDbif1R2/I+6iovlXR
         ZYYyOPg01SA0eqHRBoRjE+UkCg7QIntInxi8GqvffnwuXwWDnfXyT9U1C2iH3CoO7Tq6
         KAv/OxG8iMqhWdsYa8ULqCOq7kWU6nkpcjWXfJ1A+4n9OeCkN0OrDtibBCgdLTq9w3wD
         n3x9kD2BWsgo1KCZqVxRj+wI4kb6pPWdaYBpckoPvT55n/OuIJHvZ4OpcTqxP0ShM1oc
         bc+w==
X-Gm-Message-State: AOAM531BaVsXIYws9sjxj5MtKGZ6K0PVbRnNGId7ivrh9OuviFZ9WgI9
        GhTRoGpvKwpNUbD//yVL1J1uTui+D14FjHOomh8zHFwCPKdMhqXG8d3hocBa9ZJFIu4GffqAq9Z
        WsKSlViJtmiW26UafEzS1sVvqjer1nDC7M6cmcXtor7xq
X-Received: by 2002:a02:8b:: with SMTP id 133mr5485105jaa.92.1614884114294;
        Thu, 04 Mar 2021 10:55:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVKhtCZrJ3XafzaSd4FWRa4mDR7Yr2a72L2F+S83CirYgxeb8NeJyXDPxP7NsKahQxR8DORHdGI0U8SdAI+aA=
X-Received: by 2002:a02:8b:: with SMTP id 133mr5485088jaa.92.1614884113960;
 Thu, 04 Mar 2021 10:55:13 -0800 (PST)
MIME-Version: 1.0
References: <CAPOPQMD7qYCaNWsznoTH1fr+Xy1QKjfMBhpA4y4RByDpnOFWnw@mail.gmail.com>
 <267e17b48256913a377bf8057fa3f4c6890478f5.camel@esd.eu>
In-Reply-To: <267e17b48256913a377bf8057fa3f4c6890478f5.camel@esd.eu>
From:   Xuheng Li <xuheng@cs.columbia.edu>
Date:   Thu, 4 Mar 2021 13:55:03 -0500
Message-ID: <CAPOPQMBv4CEhS8Kg3zZw4HvD4eOmQqgT+HdFfBadDuzkMk2dTQ@mail.gmail.com>
Subject: Re: Possible Bug on Xgene PCIe Driver
To:     =?UTF-8?Q?Stefan_M=C3=A4tje?= <Stefan.Maetje@esd.eu>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_05:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_notspam policy=inbound score=0 impostorscore=10 bulkscore=10
 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=10 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040088
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Yes that makes sense. I sort just focus on the diff lines without
looking further.

Thanks.

--
Xuheng Li

On Thu, Mar 4, 2021 at 1:36 PM Stefan M=C3=A4tje <Stefan.Maetje@esd.eu> wro=
te:
>
> Am Dienstag, den 02.03.2021, 22:51 -0500 schrieb Xuheng Li:
> > Hi,
> >
> > We are using Linux 5.10 on a HPE Proliant m400 machine with an XGene
> > PCIe bridge. The machine works well on some earlier versions like 5.4
> > but fails to set up the PCIe bridge on 5.10.
> >
> > Running `lscpi` on 5.4 shows:
> > 00:00.0 PCI bridge: Applied Micro Circuits Corp. X-Gene PCIe bridge (re=
v 04)
> > 01:00.0 Ethernet controller: Mellanox Technologies MT27520 Family
> > [ConnectX-3 Pro]
> >
> > while on 5.10 it shows nothing.
> >
> > The earliest commit we found that causes the bug is
> >
> https://lore.kernel.org/linux-pci/20200602171601.17630-1-zhengdejin5@gmai=
l.com/
> > which changes the file drivers/pci/controller/pci-xgene.c by wrapping
> > the call of devm_platform_ioremap_resource_byname into
> > platform_get_resource_byname.
> >
> > By reverting the change, the PCIe bridge works now. We are curious why
> > this patch can cause the issue.
> >
> > Additionally, this bug still exists on 5.10.19 and reverting the above
> > patch also fixed the issue.
> >
> > Any help would be appreciated!
> >
>
> Being curious I've been looking at the diff from the mentioned patch for =
the
> pci-xgene.c source:
>
> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/=
pci-
> xgene.c
> index d1efa8ffbae1..1431a18eb02c 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -355,8 +355,7 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port =
*port,
>         if (IS_ERR(port->csr_base))
>                 return PTR_ERR(port->csr_base);
>
> -       res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg")=
;
> -       port->cfg_base =3D devm_ioremap_resource(dev, res);
> +       port->cfg_base =3D devm_platform_ioremap_resource_byname(pdev, "c=
fg");
>         if (IS_ERR(port->cfg_base))
>                 return PTR_ERR(port->cfg_base);
>         port->cfg_addr =3D res->start;    /* <=3D=3D=3D=3D */
>
> I think you can see the error even from this short snippet. In the workin=
g case
> with the lines marked with "-" present the res variable is set by
> platform_get_resource_byname() correctly. Then it can be used to set up
> port->cfg_addr in the line marked by /* <=3D=3D=3D=3D */.
>
> In the failure case with the line marked with "+" only active the res var=
iable
> is not updated by devm_platform_ioremap_resource_byname() and carries dat=
a from
> an earlier resource search or even is uninitialized. The value set to
> port->cfg_addr will be crap with a high probability I think.
>
> Best regards,
>     Stefan
>
