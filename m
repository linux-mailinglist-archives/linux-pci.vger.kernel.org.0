Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4150FD30F9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfJJS4j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 14:56:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726387AbfJJS4j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2019 14:56:39 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9AIlpKF190448;
        Thu, 10 Oct 2019 14:56:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vj96ca8gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 14:56:30 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9AImMln192161;
        Thu, 10 Oct 2019 14:56:30 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vj96ca8gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 14:56:30 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9AIpffI000934;
        Thu, 10 Oct 2019 18:56:29 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 2vejt7vv0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 18:56:29 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9AIuSCC53018942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 18:56:28 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D4E06E04E;
        Thu, 10 Oct 2019 18:56:28 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63A9F6E050;
        Thu, 10 Oct 2019 18:56:28 +0000 (GMT)
Received: from localhost (unknown [9.41.179.186])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 10 Oct 2019 18:56:28 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, bhelgaas@google.com
Subject: Re: [RFC PATCH 1/9] powerpc/pseries: add cpu DLPAR support for drc-info property
In-Reply-To: <1569910334-5972-2-git-send-email-tyreld@linux.ibm.com>
References: <1569910334-5972-1-git-send-email-tyreld@linux.ibm.com> <1569910334-5972-2-git-send-email-tyreld@linux.ibm.com>
Date:   Thu, 10 Oct 2019 13:56:28 -0500
Message-ID: <871rvkjuoz.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910100160
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Tyrel,

Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> +static bool valid_cpu_drc_index(struct device_node *parent, u32 drc_index)
> +{
> +	const __be32 *indexes;
> +	int i;
> +
> +	if (of_find_property(parent, "ibm,drc-info", NULL))
> +		return drc_info_valid_index(parent, drc_index);
> +
> +	indexes = of_get_property(parent, "ibm,drc-indexes", NULL);
> +	if (!indexes)
> +		return false;
> +
> +	for (i = 0; i < indexes[0]; i++) {

should this be:

        for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
?


> +		if (be32_to_cpu(indexes[i + 1]) == drc_index)
> +			return true;
> +	}
> +
> +	return false;
>  }

It looks like this rewrites valid_cpu_drc_index()'s existing code for
parsing ibm,drc-indexes but I don't see the need for this.

This patch would be easier to review if that were dropped or split out.

>  
>  static ssize_t dlpar_cpu_add(u32 drc_index)
> @@ -720,8 +756,11 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
>  static int find_dlpar_cpus_to_add(u32 *cpu_drcs, u32 cpus_to_add)
>  {
>  	struct device_node *parent;
> +	struct property *info;
> +	const __be32 *indexes;
>  	int cpus_found = 0;
> -	int index, rc;
> +	int i, j;
> +	u32 drc_index;
>  
>  	parent = of_find_node_by_path("/cpus");
>  	if (!parent) {
> @@ -730,24 +769,46 @@ static int find_dlpar_cpus_to_add(u32 *cpu_drcs, u32 cpus_to_add)
>  		return -1;
>  	}
>  
> -	/* Search the ibm,drc-indexes array for possible CPU drcs to
> -	 * add. Note that the format of the ibm,drc-indexes array is
> -	 * the number of entries in the array followed by the array
> -	 * of drc values so we start looking at index = 1.
> -	 */
> -	index = 1;
> -	while (cpus_found < cpus_to_add) {
> -		u32 drc;
> +	info = of_find_property(parent, "ibm,drc-info", NULL);
> +	if (info) {
> +		struct of_drc_info drc;
> +		const __be32 *value;
> +		int count;
>  
> -		rc = of_property_read_u32_index(parent, "ibm,drc-indexes",
> -						index++, &drc);
> -		if (rc)
> -			break;
> +		value = of_prop_next_u32(info, NULL, &count);
> +		if (value)
> +			value++;
>  
> -		if (dlpar_cpu_exists(parent, drc))
> -			continue;
> +		for (i = 0; i < count; i++) {
> +			of_read_drc_info_cell(&info, &value, &drc);
> +			if (strncmp(drc.drc_type, "CPU", 3))
> +				break;
> +
> +			for (j = 0; j < drc.num_sequential_elems; j++) {
> +				drc_index = drc.drc_index_start + (drc.sequential_inc * j);
> +
> +				if (dlpar_cpu_exists(parent, drc_index))
> +					continue;
>  
> -		cpu_drcs[cpus_found++] = drc;
> +				cpu_drcs[cpus_found++] = drc_index;

I am failing to see how this loop is limited by the cpus_to_add
parameter as it was before this change. It looks like this will overflow
the cpu_drcs array when cpus_to_add is less than the number of cpus
found.

As an aside I don't understand how the add_by_count()/dlpar_cpu_exists()
algorithm could be correct as it currently stands. It seems to pick the
first X indexes for which a corresponding cpu node is absent, but that
set of indexes does not necessarily match the set that is available to
configure. Something to address separately I suppose.

> +			}
> +		}
> +	} else {
> +		indexes = of_get_property(parent, "ibm,drc-indexes", NULL);
> +
> +		/* Search the ibm,drc-indexes array for possible CPU drcs to
> +	 	* add. Note that the format of the ibm,drc-indexes array is
> +	 	* the number of entries in the array followed by the array
> +	 	* of drc values so we start looking at index = 1.
> +	 	*/
> +		for (i = 1; i < indexes[0]; i++) {
> +			drc_index = be32_to_cpu(indexes[i]);
> +
> +			if (dlpar_cpu_exists(parent, drc_index))
> +				continue;
> +
> +			cpu_drcs[cpus_found++] = drc_index;
> +		}
>  	}

As above, not sure why this was rewritten, and similar comments as
before apply.
