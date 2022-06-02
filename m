Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4857353BCE8
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 18:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbiFBQzT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 12:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiFBQzS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 12:55:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE0E280B04;
        Thu,  2 Jun 2022 09:55:17 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252ElSe0030355;
        Thu, 2 Jun 2022 16:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=3QGpyi15ADQCpJqFxbfSJxJ4l8rD4MAyDEb7SZzXCj8=;
 b=LKVwfCdR/gdDCMqaYq7lGuc0q3jIodDSqDS17Av/8LOX0k26neKYHdEZZYT86kQ13EVV
 o1bPU6o43rpEPpx3H6gLLEIZ2RFXp5JjLxv/kSKTmDejIlSap0EKOpM1dp0gHAz8vSZ1
 xxLp1s5jBhFVPm7P0Jtf6kXust9njJxC9iFPt7nyYDcFSoDcp/ZXRysbxXZcS/3sJsCw
 mnZq9fNGveojqhVjSBlC18ZUK+ZtChNztizaVYqZzdIyXiaJLPExGB8kOfzw75J/I4zu
 v/v0WEAxmJbv2uvbosXoneMMFakosbff7bLfnzhOEs3jvLUYegbPZnsXs1NDRkF2+l30 Jg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gey95aa8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 16:55:13 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 252Gq6jH003656;
        Thu, 2 Jun 2022 16:55:12 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01dal.us.ibm.com with ESMTP id 3gcxt5urq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 16:55:12 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 252GtBWd32833926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jun 2022 16:55:11 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D82678072;
        Thu,  2 Jun 2022 16:55:11 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFC957806B;
        Thu,  2 Jun 2022 16:55:10 +0000 (GMT)
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [9.211.86.50])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jun 2022 16:55:10 +0000 (GMT)
Message-ID: <575d1720aa070bf46097510a6c29c2e91276ff7d.camel@linux.ibm.com>
Subject: Re: Fwd: [Bug 216059] New: Scsi host number of Adaptec RAID
 controller changes upon a PCIe hotplug and re-insert
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     bjorn@helgaas.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        sagar.biradar@microchip.com
Date:   Thu, 02 Jun 2022 12:55:09 -0400
In-Reply-To: <CABhMZUXf1hD-phj5p2BB62WC9eK9SRZUOutsfSinUKf_bWCC2g@mail.gmail.com>
References: <bug-216059-41252@https.bugzilla.kernel.org/>
         <CABhMZUXf1hD-phj5p2BB62WC9eK9SRZUOutsfSinUKf_bWCC2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1RauoihfGJJue41cmpYcEBvCBbb67pAz
X-Proofpoint-ORIG-GUID: 1RauoihfGJJue41cmpYcEBvCBbb67pAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_05,2022-06-02_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 clxscore=1011 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206020068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2022-06-02 at 11:46 -0500, Bjorn Helgaas wrote:
> From bugzilla.  Reported against PCI, but I think the SCSI host
> number is determined by SCSI, not by PCI, so I don't see a PCI issue
> here.

Agree this is SCSI.  However, can we be clear about what the
expectation is?  Host Number looks like it should be expected to change
on hot plug/hot unplug, so what is the actual problem?

I get that the driver not releasing the host is causing this, but even
if it did do instant release, when you hot plug two SCSI devices, you
stand a good chance of getting a different host number anyway.

James


