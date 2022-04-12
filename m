Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962674FE4B0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 17:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350391AbiDLP07 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 11:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346458AbiDLP06 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 11:26:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80F813F86;
        Tue, 12 Apr 2022 08:24:40 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CEn5t3001448;
        Tue, 12 Apr 2022 15:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=aOkAaRJ9/o0OIEzV/8mYAPmTpT2SVzZsDbDkXsifi04=;
 b=Ur9P9piuFVERhKHfUsgUBuqwEkkQlPSNFEXeiEdDD8/BF/DMpPgC6V72SiQq0MCfzaIK
 KcVNXKkrQWUa31lXzyHFSMh73+7HOd2g3/jysY/WhqMPb15GcFAJZsA89EKpfWYgWaYp
 icxV9CXjgTQfInDfHrfbupo0lpU73sRzikbvQYoRJe4fjcLZDHLtefzX56CeEYA5XBDZ
 f6fEC+GrAtHgq1aYPR7gG29PSBVqwhgaaE/2ohXgww6EBZ7Gmeue7fQmA2lKxbsd7pGa
 ATwFDv1sROcWfV+T99SmZWfIzJ0sJY7Gs1I5jK0K7BTYOr35bmfMgaGebAXzek8gWAQX +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fd7k972sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 15:24:36 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23CEnPXk002595;
        Tue, 12 Apr 2022 15:24:36 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fd7k972s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 15:24:36 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23CFHUiK017874;
        Tue, 12 Apr 2022 15:24:34 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3fbsj032jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 15:24:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23CFOVMx53608862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 15:24:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AF724C044;
        Tue, 12 Apr 2022 15:24:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D54234C040;
        Tue, 12 Apr 2022 15:24:30 +0000 (GMT)
Received: from sig-9-145-31-85.uk.ibm.com (unknown [9.145.31.85])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Apr 2022 15:24:30 +0000 (GMT)
Message-ID: <a9520a3d46aa993145e6af59c6699809e21549ca.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] PCI: Clean up pci_scan_slot()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Tue, 12 Apr 2022 17:24:30 +0200
In-Reply-To: <20220412143040.1882096-2-schnelle@linux.ibm.com>
References: <20220412143040.1882096-1-schnelle@linux.ibm.com>
         <20220412143040.1882096-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TmTHQZLhk0gOvkTKMRf7cdjCLjY-dQSF
X-Proofpoint-GUID: hyieiNt5oIAee7loC5B3STqbro1kEcWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_05,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2022-04-12 at 16:30 +0200, Niklas Schnelle wrote:
> While determining the next PCI function is factored out of
> pci_scan_slot() into next_fn() the former still handles the first
> function as a special case duplicating the code from the scan loop and
> splitting the condition that the first function exits from it being
> multifunction which is tested in next_fn().
> 
> Furthermore the non ARI branch of next_fn() mixes the case that
> multifunction devices may have non-contiguous function ranges and dev
> may thus be NULL with the multifunction requirement. It also signals
> that no further functions need to be scanned by returning 0 which is
> a valid function number.
> 
> Improve upon this by moving all conditions for having to scan for more
> functions into next_fn() and make them obvious and commented.
> 
> By changing next_fn() to return -ENODEV instead of 0 when there is no
> next function we can then handle the initial function inside the loop
> and deduplicate the shared handling.
> 
> No functional change is intended.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/probe.c | 41 +++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..389aa1f9cb2c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2579,33 +2579,35 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
>  }
>  EXPORT_SYMBOL(pci_scan_single_device);
>  
> -static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
> -			    unsigned int fn)
> +static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
>  {
>  	int pos;
>  	u16 cap = 0;
>  	unsigned int next_fn;
>  
> -	if (pci_ari_enabled(bus)) {
> -		if (!dev)
> -			return 0;

This part here theoretically changes the behavior slightly. If the ARI
information is wrong/lands us in a "hole" we may look for more
functions via the non-ARI path. Not sure if that is relevant though as
in the worst case we might find functions that we otherwise wouldn't
have seen. Seems rather obsure to me but I might be wrong, we currently
don't see the ARI capability in Linux on IBM Z so I have less
experience with this. I did of course boot test on my x86_64
workstation.

> +	if (dev && pci_ari_enabled(bus)) {
>  		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
>  		if (!pos)
> -			return 0;
> +			return -ENODEV;
>  
>  		pci_read_config_word(dev, pos + PCI_ARI_CAP, &cap);
>  		next_fn = PCI_ARI_CAP_NFN(cap);
>  		if (next_fn <= fn)
> -			return 0;	/* protect against malformed list */
> +			return -ENODEV;	/* protect against malformed list */
>  
>  		return next_fn;
>  	}
>  
> -	/* dev may be NULL for non-contiguous multifunction devices */
> -	if (!dev || dev->multifunction)
> -		return (fn + 1) % 8;
> -
> -	return 0;
> +	/* only multifunction devices may have more functions */
> +	if (dev && !dev->multifunction)
> +		return -ENODEV;
> +	/*
> +	 * A function 0 is required but multifunction devices may
> +	 * be non-contiguous so dev can be NULL otherwise.
> +	 */
> +	if (!fn && !dev)
> +		return -ENODEV;
> +	return (fn <= 6) ? fn + 1 : -ENODEV;
>  }
>  
> 
---8<---


