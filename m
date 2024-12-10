Return-Path: <linux-pci+bounces-17980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E26389EA67F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 04:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC9A1886B1E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 03:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B9269D2B;
	Tue, 10 Dec 2024 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQGsFigI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BE13AC1;
	Tue, 10 Dec 2024 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733800787; cv=none; b=sM56BwoWSDTQWkJzguotr6DwINrnc86924LxDNSElfhUGeSex5dD+tyjmauSfv1LNCHaQuW1/7ViywTkODkmMg5WTWnFDulp2M97TZl5Xi3r8G280RLoRdZQtbNZb4OSBv+ZdlZgNUC4G2gveFNFy4oPvN5Pr8vAAnARMZELpgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733800787; c=relaxed/simple;
	bh=lEwucMc9HgKjkcmlGPT3eXRxcPVzt4cX7HPBzWU8CL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MGSYLFaP6J/6+jF3GEDDuaC0/8BnELcsjcj30ziGfzVcQXGr0GxezKOP/rVXMbxCZ580LxFI178kExGXzLb1WzRdwGmSfMMuSJY4T8OtFlm1nIJz0SJbC28NZ5Ppjhx6tMMGnvd5YYrOost7K6XL6ieP7tXRvuG/zT3OCekztXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQGsFigI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E81AC4CED6;
	Tue, 10 Dec 2024 03:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733800786;
	bh=lEwucMc9HgKjkcmlGPT3eXRxcPVzt4cX7HPBzWU8CL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jQGsFigI5h1cXweAjY4YUQUa6Jiv3gjqXAHvc6cOvBuwxJKll03p5PpsvCGumLTL8
	 Di5VUurEmBkRm9eBq0oM1+FXAYw6AgghpAW79gL16d7nv2dk1HKLOqDE/Mrqcy80Yn
	 /zDQLmtSYqcWbZaUpbT/Sm5afxy7YQv+uMkd74LlRfCXB6ux04N7KcRbzVQvzr37nS
	 Ui9C8KUKpjJeaVo9fUIgNVbZphyBFDun85xuvuC4CjpsYmFi1ubQspHCt2kBT5TPGR
	 htF5EKsobbGjtv57A2lnA7v3bqYLAH/jerFhoRf0+ZkL/xGo8uNCci6bpHApJOITmO
	 rhMeCBVEJs3Ng==
X-Mailer: emacs 31.0.50 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
In-Reply-To: <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
Date: Tue, 10 Dec 2024 08:49:40 +0530
Message-ID: <yq5ay10oz0kz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Dan,

Dan Williams <dan.j.williams@intel.com> writes:
> +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
> +			 enum pci_ide_flags flags)
> +{
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	int mem = 0, rc;
> +
> +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> +		pci_err(pdev, "Setup fail: Invalid stream id: %d\n", ide->stream_id);
> +		return -ENXIO;
> +	}
> +
> +	if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
> +		pci_err(pdev, "Setup fail: Busy stream id: %d\n",
> +			ide->stream_id);
> +		return -EBUSY;
> +	}
> +

Considering we are using the hostbridge ide_stream_ids bitmap, why is
the stream_id allocation not generic? ie, any reason why a stream id alloc
like below will not work?

static int pcie_ide_sel_streamid_alloc(struct pci_dev *pdev)
{
	int stream_id;
	struct pci_host_bridge *hb;

	hb = pci_find_host_bridge(pdev->bus);

	stream_id = find_first_zero_bit(hb->ide_stream_ids, hb->nr_ide_streams);
	if (stream_id >= hb->nr_ide_streams)
		return -EBUSY;

	return stream_id;
}

-aneesh

