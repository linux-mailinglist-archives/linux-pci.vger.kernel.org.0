Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAA36B2D01
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 19:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCIShf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 13:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCIShb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 13:37:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A043F34E7;
        Thu,  9 Mar 2023 10:37:24 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329HJF8t007118;
        Thu, 9 Mar 2023 18:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2ITuG61p1HaH14xvSdlo2fftqfM4Xi1T38WrR/arjXY=;
 b=Ob4X1LD/+OSrbpWFtKEIF/DpxW14t7LcjKV7Z5LkDA6EfJ12iPsaAaqL4Is2zNQUZCZV
 pzJ996mpZZJCAzY/pKeTbrLYZ/FIOK58CKdfFPFXyEhJorkUhFaNL3IC0kAZakPcRqlf
 Rtxy4p+2A1tA2OToz+LTzgKMBAmFMJdGs6GDoeT+NOXsHvzzBX6Xv+Mh8Nx1z79IWA5m
 IgaV7gzxPGF4+L9aikW+YU6CI8y1+Ewkrt8betwCgmcM7k9NVXTqiXs9g+pBfJ6lMg+c
 InENUBiQNEFI/ciZwDj1+RhjbMD/HS6qjynOWqXtBhmVF7X0z3DvVic5wIxy8pcGswxV mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6s9bcsck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:37:23 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329HP2vj019391;
        Thu, 9 Mar 2023 18:37:22 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6s9bcsc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:37:22 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 329FYlE1024879;
        Thu, 9 Mar 2023 18:37:21 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3p6g9jahyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:37:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 329IbK5N59769268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Mar 2023 18:37:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B9985805D;
        Thu,  9 Mar 2023 18:37:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21DAF58059;
        Thu,  9 Mar 2023 18:37:19 +0000 (GMT)
Received: from [9.160.169.251] (unknown [9.160.169.251])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Mar 2023 18:37:19 +0000 (GMT)
Message-ID: <a2ba8512-75fa-4c4f-c4b1-4956f0905203@linux.ibm.com>
Date:   Thu, 9 Mar 2023 13:37:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/4] s390/pci: clean up left over special treatment for
 function zero
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20230306151014.60913-1-schnelle@linux.ibm.com>
 <20230306151014.60913-5-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230306151014.60913-5-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eSsC9A2KKyfSWkJjnrYQureXLswCL3oS
X-Proofpoint-GUID: iSIXujAUab5RzYn3HCOQOnFGVmxWcrJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_10,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090148
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/6/23 10:10 AM, Niklas Schnelle wrote:
> Prior to commit 960ac3626487 ("s390/pci: allow zPCI zbus without
> a function zero") enabling and scanning a PCI function had to
> potentially be postponed until the function with devfn zero on that bus
> was plugged. While the commit removed the waiting itself extra code to
> scan all functions on the PCI bus once function zero appeared was
> missed. Remove that code and the outdated comments about waiting for
> function zero.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/pci/pci.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index e16afacc8fd1..f5709b5dae7a 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -874,32 +874,15 @@ bool zpci_is_device_configured(struct zpci_dev *zdev)
>   * @fh: The general function handle supplied by the platform
>   *
>   * Given a device in the configuration state Configured, enables, scans and
> - * adds it to the common code PCI subsystem if possible. If the PCI device is
> - * parked because we can not yet create a PCI bus because we have not seen
> - * function 0, it is ignored but will be scanned once function 0 appears.
> - * If any failure occurs, the zpci_dev is left disabled.
> + * adds it to the common code PCI subsystem if possible.If any failure occurs,

Nit: missing space after period here

Also, while you're at this, commit 960ac3626487 removed the function 0 check from zpci_bus_scan_bus but the comment block for zpci_bus_scan_bus is still outdated.  Please fix also with this patch.

With that:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



