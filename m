Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8850414535
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 11:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhIVJfE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 05:35:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234421AbhIVJfD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 05:35:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18M9UTCK005562;
        Wed, 22 Sep 2021 05:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IwZ64YTIE0jF4hfEg0vkl89m3KgfRRaEAQHRFBtAXQ8=;
 b=EBiltKHv3nX9LGFp9DYGIiiqGeQesUe3CT9mT9yUdbVvuAsSRbuTaUS2VZa0uOlGVtun
 a23YBS8QMr/75o8Z4SmevcwQDiAaL82R7FpDyr2ZSl8daF8Wiw+3HOSuPr+R7LfMVaqx
 0cqVK5ytOwIoYSgCMXdNOM8Ot9DdBuomcvoAsHrO8j9vO00l27vtqh/iDJcafFrEopAW
 PEqRCnBXr3/xdLUOh+gssOEQeAAWgooxOxidnbN2WEPmavzgEdJh/TbtS/jWDcgQRg+4
 N5LHH9NRC+u1HH3ZipjjiG85aC66F64nNmLBl4XSLF9o3uWwqy5vb04l5lXMANMiiJoO Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b81wt81k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 05:33:20 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18M9XJ7i011394;
        Wed, 22 Sep 2021 05:33:19 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b81wt81js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 05:33:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18M9VvXL007983;
        Wed, 22 Sep 2021 09:33:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3b7q6pmupc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 09:33:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18M9XESj43188586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 09:33:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9A264C05A;
        Wed, 22 Sep 2021 09:33:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2079F4C044;
        Wed, 22 Sep 2021 09:33:14 +0000 (GMT)
Received: from [9.145.158.122] (unknown [9.145.158.122])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Sep 2021 09:33:13 +0000 (GMT)
Message-ID: <2ec319f5-1cc3-0452-31f7-79125646218e@linux.ibm.com>
Date:   Wed, 22 Sep 2021 11:33:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 5/7] PCI: Add pci_find_dvsec_capability to find designated
 VSEC
Content-Language: en-US
To:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     "David E . Box" <david.e.box@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
References: <20210921220459.2437386-1-ben.widawsky@intel.com>
 <20210921220459.2437386-6-ben.widawsky@intel.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20210921220459.2437386-6-ben.widawsky@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h7mUwWrn_daai9WsqVOl4RccbuMZlXl4
X-Proofpoint-ORIG-GUID: eHnk2Q4Qimf29OFM6CsdE5RGWJfXuYLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_03,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220066
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 22/09/2021 00:04, Ben Widawsky wrote:
> Add pci_find_dvsec_capability to locate a Designated Vendor-Specific
> Extended Capability with the specified DVSEC ID.
> 
> The Designated Vendor-Specific Extended Capability (DVSEC) allows one or
> more vendor specific capabilities that aren't tied to the vendor ID of
> the PCI component.
> 
> DVSEC is critical for both the Compute Express Link (CXL) driver as well
> as the driver for OpenCAPI coherent accelerator (OCXL).
> 
> Cc: David E. Box <david.e.box@linux.intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Frederic Barrat <fbarrat@linux.ibm.com>
> Cc: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---


LGTM
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>


>   drivers/pci/pci.c   | 32 ++++++++++++++++++++++++++++++++
>   include/linux/pci.h |  1 +
>   2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce2ab62b64cf..94ac86ff28b0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -732,6 +732,38 @@ u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
>   }
>   EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
>   
> +/**
> + * pci_find_dvsec_capability - Find DVSEC for vendor
> + * @dev: PCI device to query
> + * @vendor: Vendor ID to match for the DVSEC
> + * @dvsec: Designated Vendor-specific capability ID
> + *
> + * If DVSEC has Vendor ID @vendor and DVSEC ID @dvsec return the capability
> + * offset in config space; otherwise return 0.
> + */
> +u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
> +{
> +	int pos;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DVSEC);
> +	if (!pos)
> +		return 0;
> +
> +	while (pos) {
> +		u16 v, id;
> +
> +		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER1, &v);
> +		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER2, &id);
> +		if (vendor == v && dvsec == id)
> +			return pos;
> +
> +		pos = pci_find_next_ext_capability(dev, pos, PCI_EXT_CAP_ID_DVSEC);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> +
>   /**
>    * pci_find_parent_resource - return resource region of parent bus of given
>    *			      region
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cd8aa6fce204..c93ccfa4571b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1130,6 +1130,7 @@ u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
>   u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
>   struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
>   u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
> +u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec);
>   
>   u64 pci_get_dsn(struct pci_dev *dev);
>   
> 
