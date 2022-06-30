Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BCA561A81
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 14:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiF3Mkf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 08:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiF3Mke (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 08:40:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44574427E6;
        Thu, 30 Jun 2022 05:40:32 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UCCOG7021427;
        Thu, 30 Jun 2022 12:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MGcmts/VcLOyCctQQ+8sNs5Oo2ke3WkHJIEB4BMXULs=;
 b=ajroneAEBC5+pinKYj91ZsyDsdq30sT0GMXsXjQNJp7+odvctOHrF0PPstsPeCxuAsnF
 uoUjD9489TP3uSnR+2LL+qXIL5TFSoZKDdpbqC+eshAMNwFS5mZh8dQoTSDqAqyyyR2U
 Pyqkc0IX2m8TS3uu8QautHLyZ+qbYAVO7wu2ukLOFIMGg5wWkVB0upuX0zFeG0hGrm11
 YUE+K3DSkP4DHYbt1C9BilVD9zDzafU1Me8jq2shVMAa460g5cDmAAI53T1nkFIQa1BR
 wkr0K8igrxLA+RaTjhflQul2K6E1B1qISRNyfzzoXBNGgZvmAxcCZTTPFV6rfV8AzUOr Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1bmmrtp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:40:29 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25UCDpPq024472;
        Thu, 30 Jun 2022 12:40:29 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1bmmrtmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:40:29 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25UCaFLH022116;
        Thu, 30 Jun 2022 12:40:26 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3gwt0962h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:40:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25UCeNIF17694984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 12:40:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 414F85204F;
        Thu, 30 Jun 2022 12:40:23 +0000 (GMT)
Received: from [9.171.69.2] (unknown [9.171.69.2])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DA76152052;
        Thu, 30 Jun 2022 12:40:22 +0000 (GMT)
Message-ID: <e00373b9-0fa5-a47a-5abd-3fe6a1e97327@linux.ibm.com>
Date:   Thu, 30 Jun 2022 14:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 2/5] PCI: Split out next_ari_fn() from next_fn()
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220628143100.3228092-1-schnelle@linux.ibm.com>
 <20220628143100.3228092-3-schnelle@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <20220628143100.3228092-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uoxxMEcw43c0OJTEofonH_ztouIehK3s
X-Proofpoint-ORIG-GUID: KqKsc2nO8z287lWQ6roeLDMCIFk1Z8jp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/28/22 16:30, Niklas Schnelle wrote:
> In commit b1bd58e448f2 ("PCI: Consolidate "next-function" functions")
> the next_fn() function subsumed the traditional and ARI based next
> function determination. This got rid of some needlessly complex function
> pointer handling but also reduced the separation between these very
> different methods of finding the next function. With the next_fn()
> cleaned up a bit we can re-introduce this separation by moving out the
> ARI handling while sticking with direct function calls.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/pci/probe.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b05d0ed83a24..2c737dce757e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2579,26 +2579,30 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
>   }
>   EXPORT_SYMBOL(pci_scan_single_device);
>   
> -static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
> +static int next_ari_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
>   {
>   	int pos;
>   	u16 cap = 0;
>   	unsigned int next_fn;
>   
> -	if (pci_ari_enabled(bus)) {
> -		if (!dev)
> -			return -ENODEV;
> -		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
> -		if (!pos)
> -			return -ENODEV;
> +	if (!dev)
> +		return -ENODEV;
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
> +	if (!pos)
> +		return -ENODEV;
> +
> +	pci_read_config_word(dev, pos + PCI_ARI_CAP, &cap);
> +	next_fn = PCI_ARI_CAP_NFN(cap);
> +	if (next_fn <= fn)
> +		return -ENODEV;	/* protect against malformed list */
>   
> -		pci_read_config_word(dev, pos + PCI_ARI_CAP, &cap);
> -		next_fn = PCI_ARI_CAP_NFN(cap);
> -		if (next_fn <= fn)
> -			return -ENODEV;	/* protect against malformed list */
> +	return next_fn;
> +}
>   
> -		return next_fn;
> -	}
> +static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
> +{
> +	if (pci_ari_enabled(bus))
> +		return next_ari_fn(bus, dev, fn);
>   
>   	if (fn >= 7)
>   		return -ENODEV;
> 

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>


-- 
Pierre Morel
IBM Lab Boeblingen
