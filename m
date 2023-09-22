Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E4A7AA65B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 03:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjIVBGe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 21:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjIVBGd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 21:06:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041E6195;
        Thu, 21 Sep 2023 18:06:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LIsR7Z018736;
        Fri, 22 Sep 2023 01:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=PaV2/eM0GTH4uo+cZQYOKUgL2TPNKr4vxGBi/Auf04c=;
 b=bfUxlRQpdJ4bBoRxasUV9RwYTDGBe3oVsuLOsIsIb5LcOXdHd6yXw8i75zzYfJgOc0Zs
 qzDsQVxZB8PINutrlwU/SHg7YFUj6Mx2EzmJm9zPpt8uHbw5FvJcg4oPyEwfusEVCgWQ
 kqrI03p0/6c8OJPQ/q+ewyFZiQiLLHjg/g26ykYbCT/Pfg4XJr5nLZ4QSr9/2kYWSciZ
 T2BM0EIJdbgjfoQ+pZ/iJNRbem4lPZTjnP2AmJEBNFoLqrMKrLNyLTnwiN3w3MaI0HFx
 EVoLLiWcZe8eEiCdvPTJm0RVKvLKhbOCIY5vLS7ackLP/Ips4W8/7oPkNMBD6+N+XJRF Bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt00ka9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 01:06:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LMjJbi040584;
        Fri, 22 Sep 2023 01:06:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u19bn40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 01:06:08 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38M164sv032168;
        Fri, 22 Sep 2023 01:06:08 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3t8u19bn0m-4;
        Fri, 22 Sep 2023 01:06:07 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/10] PCI/treewide: PCIe capability access cleanups
Date:   Thu, 21 Sep 2023 21:05:54 -0400
Message-Id: <169534443603.456601.11816529763697878783.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
References: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_01,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220008
X-Proofpoint-GUID: nHAfgE7Y28nFPrLNBjnRIzOL48I-snaf
X-Proofpoint-ORIG-GUID: nHAfgE7Y28nFPrLNBjnRIzOL48I-snaf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 13 Sep 2023 15:27:38 +0300, Ilpo Järvinen wrote:

> Instead of custom code to extract the PCIe capabilities, make the code
> more obvious using FIELD_GET/PREP().
> 
> Also cleanup some duplicated defines in e1000e.
> 
> I've only put Jonathan's Reviewed-by to patches I didn't modify
> significantly.
> 
> [...]

Applied to 6.7/scsi-queue, thanks!

[07/10] scsi: esas2r: Use FIELD_GET() to extract PCIe capability fields
        https://git.kernel.org/mkp/scsi/c/5532f2495150
[08/10] scsi: qla2xxx: Use FIELD_GET() to extract PCIe capability fields
        https://git.kernel.org/mkp/scsi/c/dc1d7b363301

-- 
Martin K. Petersen	Oracle Linux Engineering
