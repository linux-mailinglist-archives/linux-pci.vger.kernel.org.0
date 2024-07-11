Return-Path: <linux-pci+bounces-10135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E34DA92DEBD
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 05:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F1DB223FA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 03:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12F510A01;
	Thu, 11 Jul 2024 03:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mfNvUZjT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE6653;
	Thu, 11 Jul 2024 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720667364; cv=none; b=mh/TVtTgGzx4jFpml4szyaUq5vrN1CCumgmPt8XBEA4W/uy3V4v6hxQ6DJVY23ZBXAggosutyYCdoIthKFFrHUBGaNx1gfl1WUAyBjsXyT0bDeUPnSxJ3pj0+Kx9KBIxYu5a9S54I5QRmMrE/D5zaDYGUONZZjUPJesVzurLpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720667364; c=relaxed/simple;
	bh=J/b3xo6SSIvFsudqLgooyR7T1XQfnA9awPL101zA8MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyJEhZgZWaj0amlfQNz3zcn7o526lrMFpWQo3QTWMjSNPGZM7LfFwaWKBqVGJdfytqfRWEhDd0pEqAFnAQ3Bo7+w7ySKETsrX5sC9gY+H67mvk/DJFy+hc7TYTo1bvCwyaf2TWX12Ui4/WhBTPj6/wyxWwmPCxkH2g/zpjmgiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mfNvUZjT; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AGCrkB006147;
	Thu, 11 Jul 2024 03:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	corp-2023-11-20; bh=VrLzjk7AnwehuaxAT6Nv2z2+faTmaHL6o+u4wIkHNuM=; b=
	mfNvUZjTFAgDLuaRRKv6YkUkmUoMq/gmUplNKI7WHVdE3urQeIlX1xRKI9Qgx+4e
	vmYzgJVo+CU9lqAr5IjRzKWD9PqkQ5tihGJnC+QqpFV2UrtCPqiATJF9u0iblwvI
	HsuvIKNcjgQL2QvDtky8ZzdeuGX/2fo9i2FNuYd53fWteEUJN/DxF/s+dvnF1g4K
	gubzyZS8fmEWCbH6c9h8ezaBANza1GxSNFc40Bg6qyhByuGCcXu8qIpc9tPkHNPE
	yZxmq/2zjrH1sRCEFiYa9w1ML0EuI92y9lCwuwTe9OFxbLeepUv85qialpKFHYhJ
	Ng2JSVigDkjDhXzPKmgqAQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknrn3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 03:09:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B1Dn45008741;
	Thu, 11 Jul 2024 03:09:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3x4cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 03:09:17 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46B39D9l006490;
	Thu, 11 Jul 2024 03:09:17 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 409vv3x4ar-3;
	Thu, 11 Jul 2024 03:09:17 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: helgaas@kernel.org, sathya.prakash@broadcom.com,
        chandrakanth.patil@broadcom.com, ranjan.kumar@broadcom.com,
        prayas.patel@broadcom.com, Sumit Saxena <sumit.saxena@broadcom.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/3] mpi3mr: Support PCI Error Recovery
Date: Wed, 10 Jul 2024 23:08:34 -0400
Message-ID: <172066369909.698281.5637201991992996664.b4-ty@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627101735.18286-1-sumit.saxena@broadcom.com>
References: <20240627101735.18286-1-sumit.saxena@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_20,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=972 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110020
X-Proofpoint-GUID: qD8LcFrIfdTNldOdu6G6HjYOMXt7KDsi
X-Proofpoint-ORIG-GUID: qD8LcFrIfdTNldOdu6G6HjYOMXt7KDsi

On Thu, 27 Jun 2024 15:47:32 +0530, Sumit Saxena wrote:

> This patch series contains the changes done in the driver to support
> PCI error recovery. It is rework of older patch series from Ranjan Kumar,
> see [1].
> 
> [1] https://lore.kernel.org/all/20231214205900.270488-1-ranjan.kumar@broadcom.com/
> 
> v1->v2:
> - AER patch split as suggested by Bjorn Helgaas.
> - Updated driver version to a new value.
> 
> [...]

Applied to 6.11/scsi-queue, thanks!

[1/3] mpi3mr: Support PCI Error Recovery callback handlers
      https://git.kernel.org/mkp/scsi/c/30bafe1774f0
[2/3] mpi3mr: Prevent PCI writes from driver during PCI error recovery
      https://git.kernel.org/mkp/scsi/c/1c342b0548e3
[3/3] mpi3mr: driver version update
      https://git.kernel.org/mkp/scsi/c/cf82b9e866b6

-- 
Martin K. Petersen	Oracle Linux Engineering

