Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8AD513E8E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 00:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352869AbiD1WfC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 18:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbiD1WfC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 18:35:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0982D74DD6;
        Thu, 28 Apr 2022 15:31:46 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SKpWDk022478;
        Thu, 28 Apr 2022 22:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=ZHei3AmziMOc2ZCq17jBr4Aqt3V9+CsjQoOHXb+Qrys=;
 b=DbUZqUqkB31z4mEo+zTlHU5cUifNDOf/iuWZaZuCPnEgkBlC2ATKV8f4FCXBjmjyBCfp
 YEHab2zkaj4xGlFVHrxhwL2KIKp9FvRJGufqFnnHqpwQkpomnnCx+chCW6+9RLfVcvwm
 mzLPk0MDUQk0ovaTkH+6cyHQPB+4AN8a32fiYG4REv/D5Z4GtntykQRdF4G1ua+l+Jzx
 q7+unwAxiZ+N/5RmG4N0ls1mTJQGZZFirAyU5ekVf9/O3bqHYZu9IArhqW1wAonvCZXd
 tqCDvL3QhQa9QbjZ9Nyks3rgdknPjM3AzNfsslUbzNn7TRz10tBqtcM5MFUAq7q/Q3fY Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqs3n7uc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 22:31:41 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23SMRxbu022259;
        Thu, 28 Apr 2022 22:31:41 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqs3n7ubv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 22:31:41 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23SMSkWP002490;
        Thu, 28 Apr 2022 22:31:40 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3fm93af7vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 22:31:40 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23SMVcnr20840856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 22:31:38 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F3D86E04E;
        Thu, 28 Apr 2022 22:31:38 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E6E76E052;
        Thu, 28 Apr 2022 22:31:38 +0000 (GMT)
Received: from localhost (unknown [9.41.178.242])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Apr 2022 22:31:38 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH v6] PCI hotplug: rpaphp: Error out on busy status from
 get-sensor-state
In-Reply-To: <20220428204740.GA42242@bhelgaas>
References: <20220428204740.GA42242@bhelgaas>
Date:   Thu, 28 Apr 2022 17:31:38 -0500
Message-ID: <87k0b8q1px.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F-0ZcXkTO6JddG-7JKT8snff0dGNk3kG
X-Proofpoint-ORIG-GUID: RZlCNLCq1bI5dUkDbS47Z6Tpwzchd8as
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_05,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Tue, Apr 26, 2022 at 11:07:39PM +0530, Mahesh Salgaonkar wrote:
>> +/*
>> + * RTAS call get-sensor-state(DR_ENTITY_SENSE) return values as per PAPR:
>> + *    -1: Hardware Error
>> + *    -2: RTAS_BUSY
>> + *    -3: Invalid sensor. RTAS Parameter Error.
>> + * -9000: Need DR entity to be powered up and unisolated before RTAS call
>> + * -9001: Need DR entity to be powered up, but not unisolated, before RTAS call
>> + * -9002: DR entity unusable
>> + *  990x: Extended delay - where x is a number in the range of 0-5
>> + */
>> +#define RTAS_HARDWARE_ERROR	(-1)
>> +#define RTAS_INVALID_SENSOR	(-3)
>> +#define SLOT_UNISOLATED		(-9000)
>> +#define SLOT_NOT_UNISOLATED	(-9001)
>
> I would say "isolated" instead of "not unisolated", but I suppose this
> follows language in the spec.  If so, you should follow the spec.

"not unisolated" is the spec language.


>> +#define SLOT_NOT_USABLE		(-9002)
>> +
>> +static int rtas_to_errno(int rtas_rc)
>> +{
>> +	int rc;
>> +
>> +	switch (rtas_rc) {
>> +	case RTAS_HARDWARE_ERROR:
>> +		rc = -EIO;
>> +		break;
>> +	case RTAS_INVALID_SENSOR:
>> +		rc = -EINVAL;
>> +		break;
>> +	case SLOT_UNISOLATED:
>> +	case SLOT_NOT_UNISOLATED:
>> +		rc = -EFAULT;
>> +		break;
>> +	case SLOT_NOT_USABLE:
>> +		rc = -ENODEV;
>> +		break;
>> +	case RTAS_BUSY:
>> +	case RTAS_EXTENDED_DELAY_MIN...RTAS_EXTENDED_DELAY_MAX:
>> +		rc = -EBUSY;
>> +		break;
>> +	default:
>> +		err("%s: unexpected RTAS error %d\n", __func__, rtas_rc);
>> +		rc = -ERANGE;
>> +		break;
>> +	}
>> +	return rc;
>
> This basically duplicates rtas_error_rc().  Why do we need two copies?

It treats RTAS_BUSY, RTAS_EXTENDED_DELAY_MIN...RTAS_EXTENDED_DELAY_MAX
differently, which is part of the point of this change.

Aside: rtas_error_rc() (from powerpc's rtas.c) is badly named. Its
conversions make sense for only a handful of RTAS calls. RTAS error
codes have function-specific interpretations.
