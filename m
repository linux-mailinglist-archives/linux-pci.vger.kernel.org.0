Return-Path: <linux-pci+bounces-38219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E05BDEB6C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F09319C47AA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC36D233711;
	Wed, 15 Oct 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="TfmKwsC7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F5521D3F8
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534297; cv=pass; b=uJON9jG5CorAfLYP6DDuz98uPbnxfQltKRkjYVAfZcgmuspPV5WKFvH1q7ac48pbwLbKPE8PzL1t4vykG9eDWEr79N6gVE1eS9yfObmdDUIbxDnN4TWM2ft+UMCSDwTG1WPblo2kb/6GNHFHIb6zMaxXKOoLxghQxheDrSyEWZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534297; c=relaxed/simple;
	bh=E2QnsoOmDEvTeEWVN1qoZiMdpBF/8hhdfYA9u5NKFT4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=aai0G2JSkAxkVTangId4mbinr8/VQenyg0/OgpCPLtsc3FCcNDBKN4tXOR5Rnn78+frqd3Q1C+K38GwvASlZO2QOmnZYACPybxtymyCFRwCg3R4OffwdUWg8+XJofHUUKyc83EXCzl17HfIsQodnap9VnHXlRXAkahA6UyxKsEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=TfmKwsC7; arc=pass smtp.client-ip=81.169.146.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760534270; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KMfi6Hr+bpElYQWQoTQ/fa3HBvK1DjrVSEtQdiHp+tngrJvD6tSmNPbUbY5lQbRrMX
    Svp2qH1hVlRJGE8zd3RjIyU99o8uNtabVvf87IDjEAJfrzJyEdWnp4fA3RlB6ybeWblX
    xz9Vd/wpFQRiMPa55xqRXxrL4Knz+Dg31viDShehkswzWwq+GsvHLfripVnei1C5KB9E
    pQE/O0t12lTCxcYv9PV6qbs/rU+mDQKTOC/yLexEI5hHACHGqIPqNH2z840GlhhkQbO2
    79GXLaTJuw0Thx2gm0L8oQP3TYN9koLXy5/BIWUm/frG7qR+j6zUqM3gYTzruXzWgIu3
    +7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760534270;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=E2QnsoOmDEvTeEWVN1qoZiMdpBF/8hhdfYA9u5NKFT4=;
    b=AkefBaOpENTuBoKnmbehgGly8Of+IlEd5V8od26C8Lwk+A9zCoMr77jYW8xoYmxRRA
    9q6wF+OixY9/5xLcJ3ViFMzHgdUfQxfVF0Jqyj4OFGdUoW/25exQINjbSYyrx69CZx8Z
    dcVXjRKlo4n4IWHOvkmfevr5zHagvYbL0f+F5abAq8qB9kT8RN+QDSWw343VDbF1UXn6
    gEscaBw3zIHi877b1vxmDx0xamRHRcEkvdw/Y/GZznuwE/yMObQUeCn8Moj44aiulPgt
    z1V4RJwHBYkXFdqbgqRsuPGOPDaNCE7PU0vFEm7gJnhLmCDQzn5AqCLlnmBUW1OpR9bM
    D3ww==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760534270;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=E2QnsoOmDEvTeEWVN1qoZiMdpBF/8hhdfYA9u5NKFT4=;
    b=TfmKwsC71jrVZXNgCQK58OG0DGJfmQHVFuAdUGR2C7arg9C+atrzX9pypGee40dVNT
    dSrMExfYosa5VWc9pMqG1ZeuQ12WRagInvzt9cP8dHTKjGP6FDOFi4jit8h0JYR6WR3G
    yc6yR5dapwzij6kBjaP82F0zpdpi/BNb6ea1sIua5rSWS9c87OwQjcaxGCbmlrWdkrdN
    0+wg0ZNqYMgl/Si0o6I1wpgDoyJe1pXNNbYNjVE4pcgiXaMUTXrTc5e7aXd7Vi2IuAFH
    EOLXd4QMuI1eqQk/Dczzd7jgU316MyXd9RiRccmfaJNAouGSW0c9HBlzqYl9bgHa3xe0
    UI0A==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5qwsy/HXXax+ofCi2ru+NWolPb67sCbW3uT"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id e2886619FDHoXcR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 15 Oct 2025 15:17:50 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Date: Wed, 15 Oct 2025 15:17:39 +0200
Message-Id: <D5EAC41A-837B-4170-8707-7CAE2D630106@xenosoft.de>
References: <76026544-3472-4953-910A-376DD42BC6D0@xenosoft.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <76026544-3472-4953-910A-376DD42BC6D0@xenosoft.de>
To: Herve Codina <herve.codina@bootlin.com>
X-Mailer: iPhone Mail (23A355)

Am 15 October 2025 at 02:59 pm, Herve Codina <herve.codina@bootlin.com> wrot=
e:

Also when it boots, it is not easy to know about the problem root cause.

In my case, it was not obvious to make the relationship on my side between
my ping timings behavior and ASPM.

Of course 'git bisect' helped a lot but can we rely on that for the average
user?

Best regards,
Herv=C3=A9

=E2=80=94-

I think I will revert these modifications for the RC2.

Patch for reverting: https://raw.githubusercontent.com/chzigotzky/kernels/re=
fs/heads/main/patches/e5500/pci.patch


