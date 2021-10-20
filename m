Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED36434A4E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 13:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJTLmV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 07:42:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39540 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229941AbhJTLmU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 07:42:20 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KB2IV5009931;
        Wed, 20 Oct 2021 07:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=78CZtA7DJdQ43AWjO1ZaxKgwY7Q4hbCToV2KM4D1BBc=;
 b=Q5EIhJrDx095fiaymSsE8mix8Bseu5owxC21Qw4q1wIAXodJi1XYW8TiYJgBcBDkMpqi
 13PcJT8IOu6G3/L6W5roW18bbUsSUc1Z6QMFFwbVb2pkU87XrI/ZWapcAWmz7w1BgURk
 leVwy8IMOcKCCAar3W2/UCqdD7smwAAJ28pYZAcifPPsXidKCJeCA6lsrEFnXrNg9xUy
 gPqAc3hLE/kgkcfiIKLtvaxkPqjlDZmDrlTOruA54mfk2Cs0Nlqrn1b3/bbUeOAbMs3A
 /aL5Pvip+QbU80655+Ni28sY584BkgT9YxTDftVULpEyPJTBx/cgzlLjmURHMBO7r8Pw YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btffvktab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 07:39:44 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19KBPhWI031782;
        Wed, 20 Oct 2021 07:39:43 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btffvkta3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 07:39:43 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19KBY0XB002979;
        Wed, 20 Oct 2021 11:39:42 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 3bqpcbk3gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 11:39:42 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19KBdgn742008842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 11:39:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02686B2070;
        Wed, 20 Oct 2021 11:39:42 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1900B206B;
        Wed, 20 Oct 2021 11:39:41 +0000 (GMT)
Received: from localhost (unknown [9.211.47.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Oct 2021 11:39:41 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tyrel Datwyler <tyreld@linux.ibm.com>, ajd@linux.ibm.com
Subject: Re: [PATCH] PCI/hotplug: Remove unneeded of_node_put() in pnv_php
In-Reply-To: <20211020094604.2106-1-wanjiabing@vivo.com>
References: <20211020094604.2106-1-wanjiabing@vivo.com>
Date:   Wed, 20 Oct 2021 06:39:41 -0500
Message-ID: <87tuhcx6v6.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3m8auIF7k-yix6-D2F7RV_h5zyUfgNLu
X-Proofpoint-ORIG-GUID: jEAV2QbqvK3Pv4qQVHoe99gfkW1sGJfZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200066
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Wan Jiabing <wanjiabing@vivo.com> writes:
> Fix following coccicheck warning:
> ./drivers/pci/hotplug/pnv_php.c:161:2-13: ERROR: probable double put.
>
> Device node iterators put the previous value of the index variable, so
> an explicit put causes a double put.

I suppose Coccinelle doesn't take into account that this code is
detaching and freeing the nodes.


> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index f4c2e6e01be0..f3da4f95d73f 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -158,7 +158,6 @@ static void pnv_php_detach_device_nodes(struct device_node *parent)
>  	for_each_child_of_node(parent, dn) {
>  		pnv_php_detach_device_nodes(dn);
>  
> -		of_node_put(dn);
>  		of_detach_node(dn);
>  	}

The code might be improved by comments explaining how the bare
of_node_put() corresponds to a "get" somewhere else in the driver, and
how it doesn't render the ongoing traversal unsafe. It looks suspicious
on first review, but I believe it's intentional and probably correct as
written.
