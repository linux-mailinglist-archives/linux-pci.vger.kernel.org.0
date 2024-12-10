Return-Path: <linux-pci+bounces-17981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC909EA6B1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 04:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627BC1675C3
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 03:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8501C242C;
	Tue, 10 Dec 2024 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC3Q0Gau"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0D208A7;
	Tue, 10 Dec 2024 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801852; cv=none; b=s1STycYbgCh+LB3chDbAQtCF4JXALh+rRaRbKfs5G3FF+knaCt36aAS1waS2KGBvmcNx/d5RC9pRXJDUVb8RUEZC4lxOkcJqrMhQz4spTdKytpclAmUTssSp0y+x5DLppiv5+fcamHBOA7IelToB6Pjx5QwoRzf0g0YduW3Mno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801852; c=relaxed/simple;
	bh=+CctYAPa/X/V3jjoiuwkylwPbkq1LEsWbKbFiEu0e6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gxzVBd6lZJUUxo3EPU7Fa3setWVBJjT/wuYxCZQ/l+JazD56hj6LI1gDLVxcARBGJEtI6vH50d6WQWNgTRh9doEw7oJJAJ57hU4LMpWnCGlZytm4UuSMvMXViN1Nv5JV7ApCxpDH78fvJGHeugoyB6ZnE73sANknQx046jqcIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC3Q0Gau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FAEC4CED6;
	Tue, 10 Dec 2024 03:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733801852;
	bh=+CctYAPa/X/V3jjoiuwkylwPbkq1LEsWbKbFiEu0e6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EC3Q0GauG9Tk40qUpMLNoNmjt3uAwQRejb7WHQ5gKB38WewHLxqxNqoh5/hOxull1
	 Lsk0FgdBbi8Ap59Roow7T7PAs+S8K2BRNeyTG6v9+u+5F5KzFvHI7TbOYyhRtxSlvm
	 YHVAakvt6M6z/0rGvuFsx31xeR6FchTkst5iE0Pv0p4J2REl7S8b/oMGsTjhc7r/cG
	 mUtV1uvC+ULL8GSfZrARNR/leEYX+7Ow9KvLeEeoK3fQ0TwPLRDIoqiKMgzEdzcVHQ
	 KYBuE+6T02QYCFX8X5XP/dlBPsswO8aARaRAmg3PhT35FvGMUyXQj6SwksezPWUkhp
	 pC/918KtXdqAg==
X-Mailer: emacs 31.0.50 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
In-Reply-To: <yq5ay10oz0kz.fsf@kernel.org>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <yq5ay10oz0kz.fsf@kernel.org>
Date: Tue, 10 Dec 2024 09:07:25 +0530
Message-ID: <yq5av7vsyzre.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Hi Dan,
>
> Dan Williams <dan.j.williams@intel.com> writes:
>> +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
>> +			 enum pci_ide_flags flags)
>> +{
>> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>> +	struct pci_dev *rp = pcie_find_root_port(pdev);
>> +	int mem = 0, rc;
>> +
>> +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
>> +		pci_err(pdev, "Setup fail: Invalid stream id: %d\n", ide->stream_id);
>> +		return -ENXIO;
>> +	}
>> +
>> +	if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
>> +		pci_err(pdev, "Setup fail: Busy stream id: %d\n",
>> +			ide->stream_id);
>> +		return -EBUSY;
>> +	}
>> +
>
> Considering we are using the hostbridge ide_stream_ids bitmap, why is
> the stream_id allocation not generic? ie, any reason why a stream id alloc
> like below will not work?
>
> static int pcie_ide_sel_streamid_alloc(struct pci_dev *pdev)
> {
> 	int stream_id;
> 	struct pci_host_bridge *hb;
>
> 	hb = pci_find_host_bridge(pdev->bus);
>
> 	stream_id = find_first_zero_bit(hb->ide_stream_ids, hb->nr_ide_streams);
> 	if (stream_id >= hb->nr_ide_streams)
> 		return -EBUSY;
>
> 	return stream_id;
> }
>

Also wondering should the stream id be unique at the rootport level? ie
for a config like below

# pwd
/sys/devices/platform/40000000.pci/pci0000:00
# ls
0000:00:01.0              available_secure_streams  power
0000:00:02.0              pci_bus                   uevent
# lspci
00:01.0 PCI bridge: ARM Device 0def
00:02.0 PCI bridge: ARM Device 0def
01:00.0 Unassigned class [ff00]: ARM Device ff80
02:00.0 SATA controller: Device 0abc:aced (rev 01)
# 
# lspci -t
-[0000:00]-+-01.0-[01]----00.0
           \-02.0-[02]----00.0
# 


I should be able to use the same stream id to program both the rootports?

-aneesh

