Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91D5305B77
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 13:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhA0Mei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 07:34:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237969AbhA0Mb3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2021 07:31:29 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10RC2Nkh117828;
        Wed, 27 Jan 2021 07:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=rwzNdVxaabwTTzTgTZiXcpB5MZiv4i4Keynxr5b824I=;
 b=VKGYx+Yu4qp0Ov/MuEfEu9mWOggHrC9iBzT/DriErNwUnp7Z7Hhi7zMFSGM3KDJX8WqB
 +hN1QC7L1GaKVhph2FRR2Eb9TttgHq8HwB2Sy85+bCDMJBRRR+zwMyxbcfOI97dGUFG0
 CTyloZkSAYkmfUodCXcbRk5JbW+LoNHAnTUuz/BN7bo1yoNDnGr/MBYHy+PJ/FNuReDx
 WG/1rSlWm6EHh8wKm2Gv8UAywyN3D4T/wrP9BzIQlrrfEFNCrylyJQ2+Yb4Ux1hQZw0R
 m5B03B9I4ikPy1xSn1z0EA1QAggwZV5UmVkM8PCCzjXvU5trcFNyq+yc461hLLjsvQ1W Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36awe7eyxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 07:30:37 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10RC30MO119656;
        Wed, 27 Jan 2021 07:30:37 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36awe7eyws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 07:30:37 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10RCEBZL002533;
        Wed, 27 Jan 2021 12:30:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 368be81ya7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 12:30:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10RCUVv446793006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 12:30:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C60442042;
        Wed, 27 Jan 2021 12:30:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE3BF42045;
        Wed, 27 Jan 2021 12:30:30 +0000 (GMT)
Received: from localhost (unknown [9.171.68.8])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 27 Jan 2021 12:30:30 +0000 (GMT)
Date:   Wed, 27 Jan 2021 13:30:29 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Fix "ordering" comment typos
Message-ID: <your-ad-here.call-01611750629-ext-5157@work.hours>
References: <20210126195042.2909405-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210126195042.2909405-1-helgaas@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_05:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=936 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101270063
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 26, 2021 at 01:50:42PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix comment typos in "ordering".
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/s390/include/asm/facility.h             | 2 +-
>  drivers/gpu/drm/qxl/qxl_drv.c                | 2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/file.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
> Unless somebody objects, I'll just merge these typo fixes via the PCI tree.
> 
> 
> diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
> index 68c476b20b57..91b5d714d28f 100644
> --- a/arch/s390/include/asm/facility.h
> +++ b/arch/s390/include/asm/facility.h
> @@ -44,7 +44,7 @@ static inline int __test_facility(unsigned long nr, void *facilities)
>  }
>  
>  /*
> - * The test_facility function uses the bit odering where the MSB is bit 0.
> + * The test_facility function uses the bit ordering where the MSB is bit 0.
>   * That makes it easier to query facility bits with the bit number as
>   * documented in the Principles of Operation.
>   */

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
