Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79CC32C271
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 01:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhCCUyO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Mar 2021 15:54:14 -0500
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74]:65342 "EHLO
        mx0a-00364e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352763AbhCCEO1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Mar 2021 23:14:27 -0500
X-Greylist: delayed 1325 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Mar 2021 23:14:23 EST
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
        by mx0a-00364e01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1233hOlP009882
        for <linux-pci@vger.kernel.org>; Tue, 2 Mar 2021 22:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version : from
 : date : message-id : subject : to : content-type; s=pps01;
 bh=0naWoCU2xm/oh8yTc+Zfrh/WkiZyI1HhO+F7RxBBNH0=;
 b=aTd+fAGLQ6mWVDmk4Z/UM0p8RQdRW9aiPSJrKJdpYTGTOggSbnHjMxqSQVPfJN4dWiRx
 MqwxVpL+SswUqpGRcN0TCGpiXyvZynplwOc29ZEhkrG0j4RjtLltnBs/N4J5X4+MCWmL
 xgr5mIi0qlTTpWE3IqDiv6qCYnFWrsrhfOMHTXYA5XK56n3NQr7qV1CtkEbSw3wtiO+t
 X3lHE3c2Yyd319SICQt+3qY7iWd0Yqx5GIuxhJQMclWAyF/T7xi8LOHV0syR3s5GgwyJ
 IE4PU21xopSqxrj69uLagvf+m50bU+MaOWnilanzeDChbu4QrOdJ/Cmy3YdOKm9w6Y19 vA== 
Received: from sendprodmail11.cc.columbia.edu (sendprodmail11.cc.columbia.edu [128.59.72.19])
        by mx0a-00364e01.pphosted.com with ESMTP id 36ykwuxwuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Tue, 02 Mar 2021 22:51:12 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by sendprodmail11.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id 1233pBnT055465
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-pci@vger.kernel.org>; Tue, 2 Mar 2021 22:51:11 -0500
Received: by mail-il1-f198.google.com with SMTP id c16so16430263ile.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Mar 2021 19:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0naWoCU2xm/oh8yTc+Zfrh/WkiZyI1HhO+F7RxBBNH0=;
        b=YVSJKfQmteZYmGuRqByZXsVPLUn8jsonmyyCTaXvU6yspl0X1xW7EiLXZUCP8yM9Ij
         BoyFvrosVVKrcktGtWQUyrbfdM7JepW+k55cjONJXeNeDpCao0wywmJE12pCMqtkU8dN
         VURpxWh6gvrKo4NAXFwdfSOJTKKxYo7kYswNb6tQIbFnHS8Ry5RdtfpboGa/4/WIHQwb
         d/1ORzn3EcRrqzDMScAhitkawi7qNAIFO5jjyDaCvgbgHyEV/LVkmztBiMfGGyGEejIK
         mWtWLX8UoQgtb0EuV+xObGMPFBBnHTXjm224dt+GZnJOftUIjK7LNrrSDBQHpvGh7q6u
         ccww==
X-Gm-Message-State: AOAM531AcOBCh4RZdiHgeZeGoJsAQsAncbKGSun+teQJl8ZdmOCIfgNa
        4Jye+EegFVPAKHue4YD5io5IOLE93ppX3cPcSZPv3smf1CX0UpnpwNaqdojouswn14mcxhPhYEO
        snKXo6TyM/ryB5QJWwBg9IAaRk4VoPmgw8gU/n1TclI+N
X-Received: by 2002:a5d:8587:: with SMTP id f7mr13425634ioj.193.1614743471050;
        Tue, 02 Mar 2021 19:51:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwB498wyx/5yAiK5K92sNpv99wWv5k1NUN26ucv0qCII7NNFB9Ff5iXZg1yEoWcIgIZdxl7HQ9odoXzhHNmtGM=
X-Received: by 2002:a5d:8587:: with SMTP id f7mr13425614ioj.193.1614743470738;
 Tue, 02 Mar 2021 19:51:10 -0800 (PST)
MIME-Version: 1.0
From:   Xuheng Li <xuheng@cs.columbia.edu>
Date:   Tue, 2 Mar 2021 22:51:00 -0500
Message-ID: <CAPOPQMD7qYCaNWsznoTH1fr+Xy1QKjfMBhpA4y4RByDpnOFWnw@mail.gmail.com>
Subject: Possible Bug on Xgene PCIe Driver
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_notspam policy=inbound score=0 clxscore=1011 bulkscore=10
 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=736 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=10
 impostorscore=10 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030024
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

We are using Linux 5.10 on a HPE Proliant m400 machine with an XGene
PCIe bridge. The machine works well on some earlier versions like 5.4
but fails to set up the PCIe bridge on 5.10.

Running `lscpi` on 5.4 shows:
00:00.0 PCI bridge: Applied Micro Circuits Corp. X-Gene PCIe bridge (rev 04)
01:00.0 Ethernet controller: Mellanox Technologies MT27520 Family
[ConnectX-3 Pro]

while on 5.10 it shows nothing.

The earliest commit we found that causes the bug is
https://lore.kernel.org/linux-pci/20200602171601.17630-1-zhengdejin5@gmail.com/
which changes the file drivers/pci/controller/pci-xgene.c by wrapping
the call of devm_platform_ioremap_resource_byname into
platform_get_resource_byname.

By reverting the change, the PCIe bridge works now. We are curious why
this patch can cause the issue.

Additionally, this bug still exists on 5.10.19 and reverting the above
patch also fixed the issue.

Any help would be appreciated!

--
Xuheng Li
