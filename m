Return-Path: <linux-pci+bounces-38304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E9EBE1F24
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 09:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED6E19C445A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 07:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091472E36FB;
	Thu, 16 Oct 2025 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="MS0eFW4D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19712DF159
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600232; cv=pass; b=sHINigcS93f1QWa8YiSnwgaFWSP/1eAqnZ1dKpl+iDsrxft5/5/rib/wR2NGrdTyNmj0FsIFNxY8aa7soVbmkaWtp4euYAUySA4vFg0YncAWVcH7swxc8biA5pLgQLvE5tC9Xj42U9yH0LNXizIVD8jzR3164tkSePQ0+vxRy8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600232; c=relaxed/simple;
	bh=omfRFwFuup0ZF5Z4dN/shtcrXqUiRc+J4Lic1C/QBrM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=KB8QArZ7LXzzQwsy0Jkto7fHy4tlhqCGh3uw0+FLf4/PrGu8w0YMDGcoJHRTIIJBHY0PDshA30mO2uqZbVKvCDWzTSiqLEpc5/ruxVd7CHbY74KY/i2YW3AieaLckWB9SgFBhFFF5ebzcg9rPRycWam/Zju1+RfbvkAXv8JoEhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=MS0eFW4D; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760600201; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XoPg3LmvH1Y2JnBFy5C/1RMg2tcpV8KZ7I+e2kTkbuttioh5aJMHrVXJquyxPjnklv
    jVUeggTjtc6naKywTDJEoza0Z6dVX0gZf+nPXrJgvhkrSL08/n20YkHgClkpIPCZzCvb
    yHCj2Y5G3ICUPBPMpj95mMsdogYb4YuAJlFbIuXrFqtCeo21EKBWqJkLluiv/gMIx/Fx
    scZ4a/IyYtbLFL6m005IWZYu9JWBkydw5CcrylMbQs6f9vtIJ9JqhZC2qX7ZT2wPmjOI
    WfRCIJL9HTuCBSbH6fY/MTC/v3dpS+bQyLXAM0qPvAajYnjeQCyU4emY+FQA6pam+4uW
    HXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760600201;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Date:Cc:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=omfRFwFuup0ZF5Z4dN/shtcrXqUiRc+J4Lic1C/QBrM=;
    b=cSruyN/cC1tqCk8WLhay9JvQsh2y/KNP161dyn5cVjqF78awys7vJWGHaIalTued3H
    cw2vRcWElsa72P/30dqurKcbTKY7jDVuU2qOqRpw9QTCNKLG4MNC9kZCV9CxIQRW8C7X
    kxodUDY0E6TAjDcOO6FhAXd6b+693wweOMT0sEfXW+oaD/nVh0GIsqQffRHtyvnWqRE5
    Ml3m+7F5ucgjOrsxNyPf2r/JGyNEGj4dxnMO7cmizP8p1tjlTbNArlkKrxgtvTjQV5JO
    fhSKe/fAbFQrmEdhjC/JatGu2yHmYQ3V6bISwWSVAsjLea3gUTZXJyMBKggzRIJ5DNlS
    hsDQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760600201;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:References:Message-Id:Date:Cc:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=omfRFwFuup0ZF5Z4dN/shtcrXqUiRc+J4Lic1C/QBrM=;
    b=MS0eFW4D1F6Mf96PUwVqFbTvG80yMY2N7jKVm0LiHPo+og31thnBjJn1J1IA+aLLaL
    QOarNgb1wlOUlY/noxONmeAXASxlswJliW3HUF66JKahHmvkbwebd6KZ89DWFau8bp9A
    fUWgLdQ7mMW5EWkM17CrLRGjsVq6uECg3uYZqLzG6Dhv3RzUSLfOXxT+HmpNHguRDa5d
    Nd9P/8oQTZ59YQg19x8L+0Ab4YqfQ/aqx/QH2gEr/vwJymD8XdN1zC39o5cCau79dRxT
    TLmSy2RbSB2+LDkmt/Ddwns3ip+13034xE8i1CCL61iYcZWE32+z8OGaO2mMBxgZ4Caz
    dpEg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5iys3LBXHQhT9oAbY5gi9kPmpZaJCQDfE3RBQ0="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id e2886619G7aeaKW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 16 Oct 2025 09:36:40 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <A1E3F83C-3AE8-43B7-9DCB-6C38C94F8953@xenosoft.de>
Cc: Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>
Date: Thu, 16 Oct 2025 09:36:29 +0200
Message-Id: <48F07B75-2DF3-4E9A-BC22-ADF1ED96DB06@xenosoft.de>
References: <A1E3F83C-3AE8-43B7-9DCB-6C38C94F8953@xenosoft.de>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org
X-Mailer: iPhone Mail (23A355)

Is it possible to create an option in the kernel config that enables or disa=
bles the power management for PCI and PCI Express?
If yes, then I don=E2=80=99t need to revert the changes due to boot issues a=
nd less performance.=


