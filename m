Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F376B2CFE
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 19:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCIShO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 13:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCIShN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 13:37:13 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5925F9EEB;
        Thu,  9 Mar 2023 10:36:41 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329GcJ4a021186;
        Thu, 9 Mar 2023 18:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xUnHIUYsnEqka+Pe41mwZ6sap2V5P0Ei0vdh+e5RXcI=;
 b=pHfDxXKKVzuwXXqzaR6JNQZixWk+72sMmInxvrkre25KtCR3G+QP0ds8mdGsIQyseOf0
 jbnLGMIow1rPVvSOEYAsuLaaFY8A3wqab60HDHNHf7RjFpD30ohU4rDqiIS6s+8b2Oso
 SJyHhCzkAmDug2kw43gn+z3kmZ5Hbg5NrEmuezvdUefcqzDiYe/fYrxPPuGkjILTpbcV
 f2TR0xjyF1JuQZAxDZgkQXTVWIw4p6HrfeTjZ1/eU6BkgRoUjSFxZwCLMuMJxI1DGLuV
 2FZESNk06+QZqnMiPo9EyH4e61etZwMRi5jr/7VTzdZyuhwpnEsvNOPajGjHNLuu0LCe Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6sumb3wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:36:40 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329IPB3C040327;
        Thu, 9 Mar 2023 18:36:39 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6sumb3w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:36:39 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 329IAg2j016624;
        Thu, 9 Mar 2023 18:36:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3p6fhkaqcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:36:39 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 329IabKo30671554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Mar 2023 18:36:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B26358059;
        Thu,  9 Mar 2023 18:36:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CC7B58058;
        Thu,  9 Mar 2023 18:36:36 +0000 (GMT)
Received: from [9.160.169.251] (unknown [9.160.169.251])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Mar 2023 18:36:36 +0000 (GMT)
Message-ID: <4814c9d9-d79b-4634-bfe0-01d05c727ac9@linux.ibm.com>
Date:   Thu, 9 Mar 2023 13:36:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/4] s390/pci: only add specific device in
 zpci_bus_scan_device()
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20230306151014.60913-1-schnelle@linux.ibm.com>
 <20230306151014.60913-3-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230306151014.60913-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PHpNKMnxkYN7FOXG6YAHR8EjkEtFlEGP
X-Proofpoint-ORIG-GUID: 2gKFOAw4Im1k32NQ5j_HH_WT3APAvOQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_10,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090148
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/6/23 10:10 AM, Niklas Schnelle wrote:
> As the name suggests zpci_bus_scan_device() is used to scan a specific
> device and thus pci_bus_add_device() for that device is sufficient.
> Furthermore move this call inside the rescan/remove locking.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

I think a suggested by tag from Bjorn is appropriate here

Otherwise:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  arch/s390/pci/pci_bus.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index a99926af2b69..ae46c280b35f 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -85,9 +85,8 @@ int zpci_bus_scan_device(struct zpci_dev *zdev)
>  	if (!pdev)
>  		return -ENODEV;
>  
> -	pci_bus_add_device(pdev);
>  	pci_lock_rescan_remove();
> -	pci_bus_add_devices(zdev->zbus->bus);
> +	pci_bus_add_device(pdev);
>  	pci_unlock_rescan_remove();
>  
>  	return 0;

