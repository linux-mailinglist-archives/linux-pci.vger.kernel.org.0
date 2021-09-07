Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832D34030A9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 00:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344772AbhIGWDL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 18:03:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231251AbhIGWDL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Sep 2021 18:03:11 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187LwiZr031968;
        Tue, 7 Sep 2021 18:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=M3NLre3imKrWCdFZG/thQ+NIcwjy1kwY8mADZafIJBs=;
 b=adKivwUWvdKFHffSRurfPdtaU757HHkXhTo0vcXKGCni78MgrOaFXprKOWpAxwSTY6UA
 X1h3RD1wauYmTchUyHrbmwRS/8PMIZs3qGMBnxGYfQVqIdko8IeALjGZc9zOm82oBh8e
 Jc5ACzlU5DUW1hwu/cj7gjeQlA6lKS7eXBKJ4dfBH4ywjo4PTjHe850OxaoksJCY0JXP
 haqbf/8nnU+vpMHN+AlRgJLK62l23w0gLSrizr/IG4DOFjgqRqvlk9ti68UTtHEK22HD
 aRd3CSaCBGSvhbZpqwtmIPjnBzqqiZVT8v2Sd8P8NtrdtUPcI4c45W8GiMLKdmzIB6k0 gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3axgfm81up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 18:01:34 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 187M01Uq033905;
        Tue, 7 Sep 2021 18:01:34 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3axgfm81u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 18:01:34 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 187LvvER015141;
        Tue, 7 Sep 2021 22:01:33 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 3axcnn4pur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 22:01:33 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 187M1W1U23200132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Sep 2021 22:01:33 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6FB6124055;
        Tue,  7 Sep 2021 22:01:32 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC5DD12406B;
        Tue,  7 Sep 2021 22:01:31 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.169.122])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  7 Sep 2021 22:01:31 +0000 (GMT)
Subject: Re: [PATCH] pci/hotplug/pnv-php: Remove probable double put
To:     Xu Wang <vulab@iscas.ac.cn>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210907085946.21694-1-vulab@iscas.ac.cn>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <0fa7ddfa-cd65-583e-a83f-4cbcd4e7337f@linux.ibm.com>
Date:   Tue, 7 Sep 2021 15:01:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210907085946.21694-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a16-xvygUGq7bfcHPNiwH3asPIJqqLKr
X-Proofpoint-ORIG-GUID: JSSbdBOQQusVuBTPysKKMj22cm6ZMSgJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_08:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070135
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/7/21 1:59 AM, Xu Wang wrote:
> Device node iterators put the previous value of the index variable,
> so an explicit put causes a double put.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/pci/hotplug/pnv_php.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index 04565162a449..ed4d1a2c3f22 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -158,7 +158,6 @@ static void pnv_php_detach_device_nodes(struct device_node *parent)
>  	for_each_child_of_node(parent, dn) {
>  		pnv_php_detach_device_nodes(dn);
> 
> -		of_node_put(dn);
>  		of_detach_node(dn);

Are you sure this is a double put? This looks to me like its meant to drive tear
down of the device by putting a long term reference and not the short term get
that is part of the iterator.

-Tyrel

>  	}
>  }
> 

