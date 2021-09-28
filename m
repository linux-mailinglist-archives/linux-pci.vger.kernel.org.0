Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8B741A744
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 07:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhI1Fwa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 01:52:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234207AbhI1Fw3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 01:52:29 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S25neO015213;
        Tue, 28 Sep 2021 01:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=u/08SgPZUwisKxBCFBopTGT1FXF/KS3DrgTJNKvfsWw=;
 b=Su1MyId/zfXElDfwKdQFm+aBb51QNJQ0llIlvG0W9oPYZewfCBfzCqB8LF8zgaJbjzGg
 IFmx2ZTi01oLGM1jc7Yh0pwFaOW+1S/gJPlE2rK93Ud/JEnJ0HxucSL/0Jr3K1y67go0
 oy61Z556Buw8Yn3W6YnyhdrgKtcF0z9NAhiq3HwFska7do/b6tSi+4Cmz9wh/8yyUpWz
 kw/L6CgGLCEJEJETCtPB11LXPWtL0F77Y4Tt7jJyNPIq7KDoBp4ETwu2sS5uI3x4VAKM
 2IMhPsq6auxqAG0FFP5vu+gk/kOirFim8WibJ+OF66Bbc8gcSGaWj9/4ELhYqRiZ4izv rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bagubdr29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 01:50:35 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18S5RsNX018217;
        Tue, 28 Sep 2021 01:50:35 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bagubdr1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 01:50:34 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18S5RqA7030074;
        Tue, 28 Sep 2021 05:50:32 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3b9ud9rt90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 05:50:32 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18S5oTUI64356782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 05:50:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8344152063;
        Tue, 28 Sep 2021 05:50:29 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2A2EF52052;
        Tue, 28 Sep 2021 05:50:29 +0000 (GMT)
Received: from [9.81.209.82] (unknown [9.81.209.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id ADAB66013C;
        Tue, 28 Sep 2021 15:50:27 +1000 (AEST)
Subject: Re: [PATCH v2 6/9] PCI: Add pci_find_dvsec_capability to find
 designated VSEC
To:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org
Cc:     "David E . Box" <david.e.box@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        iommu@lists.linux-foundation.org
References: <20210923172647.72738-1-ben.widawsky@intel.com>
 <20210923172647.72738-7-ben.widawsky@intel.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <6009c15f-af28-d7ab-4518-ae34f32626a2@linux.ibm.com>
Date:   Tue, 28 Sep 2021 15:50:27 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210923172647.72738-7-ben.widawsky@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dfjx1jSiH5q1BslcZoUIy5Fe623U8B_f
X-Proofpoint-GUID: qfYn4FdH2rSoMQJWiL29ItmLOGF8Nqca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_03,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2109280033
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/9/21 3:26 am, Ben Widawsky wrote:
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
> Cc: Andrew Donnellan <ajd@linux.ibm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Looks good to me, it's essentially identical to the existing 
implementation in ocxl.

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
