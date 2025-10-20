Return-Path: <linux-pci+bounces-38719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFD1BF071F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 12:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD1418A16AC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0849F23B638;
	Mon, 20 Oct 2025 10:10:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018E227EB9;
	Mon, 20 Oct 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955014; cv=none; b=ZYIyTnN8BmeNMGv6le7XEN2UDhh2eubvECG3t8nbWjFb8E72gtyd7/FYthue29LP0VBfT+MKp+u271K5OjtPEorwKSexsv6mF6Vbn72tdsvV+It64UJr+Bz3/dcrf0ZdwUxsFo9Bmg+KaQKlkVHSrcU9/Avda/Cre38WJszfgdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955014; c=relaxed/simple;
	bh=lgZqOHi4EchA9o7JfHZnmG+t6GH9I7BzGinOVAgFLwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaWY3JZJUlom2OaYPoCjEGuE+XMe8B2XRmO3kDu3iC1pVr2a1bwqZzlfIRfBc1VGNCwYjjOmBmmkqPuKHESjMOQN6Igr/YstSln2/o6IN6GvYWOkalG5aEiRYEKhZNF/IFnehclqj/9Bi8aTKuoo2d5EtfRcNs9AcnjXBnntzOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 0554A20083D2;
	Mon, 20 Oct 2025 12:10:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F38DE4A12; Mon, 20 Oct 2025 12:10:03 +0200 (CEST)
Date: Mon, 20 Oct 2025 12:10:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6 3/5] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
Message-ID: <aPYKe1UKKkR7qrt1@wunner.de>
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-4-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015024159.56414-4-xueshuai@linux.alibaba.com>

On Wed, Oct 15, 2025 at 10:41:57AM +0800, Shuai Xue wrote:
> +++ b/drivers/pci/pcie/err.c
> @@ -253,6 +254,16 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  			pci_warn(bridge, "subordinate device reset failed\n");
>  			goto failed;
>  		}
> +
> +		/* Link recovered, report fatal errors of RCiEP or EP */
> +		if (state == pci_channel_io_frozen &&
> +		    (type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_RC_END)) {
> +			aer_add_error_device(&info, dev);
> +			info.severity = AER_FATAL;
> +			if (aer_get_device_error_info(&info, 0, true))
> +				aer_print_error(&info, 0);
> +			pci_dev_put(dev);
> +		}
>  	}

Where is the the pci_dev_get() to balance the pci_dev_put() here?

It feels awkward to leak AER-specific details into pcie_do_recovery().
That function is supposed to implement the flow described in
Documentation/PCI/pci-error-recovery.rst in a platform-agnostic way
so that powerpc (EEH) and s390 could conceivably take advantage of it.

Can you find a way to avoid this, e.g. report errors after
pcie_do_recovery() has concluded?

I'm also worried that errors are reported *during* recovery.
I imagine this looks confusing to a user.  The logged messages
should make it clear that these are errors that occurred *earlier*
and are reported belatedly.

Thanks,

Lukas

