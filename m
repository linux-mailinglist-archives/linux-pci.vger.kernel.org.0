Return-Path: <linux-pci+bounces-4414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDDF8700DE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 12:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32BF1C20DE7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 11:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682593B193;
	Mon,  4 Mar 2024 11:58:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2039AF1;
	Mon,  4 Mar 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553535; cv=none; b=Mm1zICzSp3A/6sNnXfv9KWkZLoWA4IC/wD4fiogwecOlNjW+9FKBm17kwktwXd+gGbjPu6jhkZbgxyCtLAu2DbRiMvtsDXsWk9aBZcSmf6sDgGwn9NzYYrN7k2GcZBn3GIUwnLY+Nxct4WB9rrTqZphcdIH73+4rIb0fIZ69inU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553535; c=relaxed/simple;
	bh=WBJN1RtGi66qZryYGdDi0CqNdD3TinNJ1Oczb5W/KiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj7IilVX45MeqhVt7q77Vee4H4UmUC0KTqyGhn5jTN7zBPsagCX9bj4ppbs6JB5vkdLAtQXPZNQTwXuA8eEO4r/G8ZBCuGze7fPe8LzPYAajBFZVt48lfetBZP6skPVsyND9CCcOtjXcC9Yxo9TKWgI91M5XAZcS9ouKR8ZHp7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 6DA48300002D0;
	Mon,  4 Mar 2024 12:58:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 605B916461; Mon,  4 Mar 2024 12:58:44 +0100 (CET)
Date: Mon, 4 Mar 2024 12:58:44 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, Smita.KoralahalliChannabasappa@amd.com,
	ilpo.jarvinen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kbusch@kernel.org
Subject: Re: [PATCH pci-next] pci/edr: Ignore Surprise Down error on hot
 removal
Message-ID: <20240304115844.GA3541@wunner.de>
References: <20240304090819.3812465-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304090819.3812465-1-haifeng.zhao@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Mar 04, 2024 at 04:08:19AM -0500, Ethan Zhao wrote:
> Per PCI firmware spec r3.3 sec 4.6.12, for firmware first mode DPC
> handling path, FW should clear UC errors logged by port and bring link
> out of DPC, but because of ambiguity of wording in the spec, some BIOSes
> doesn't clear the surprise down error and the error bits in pci status,
> still notify OS to handle it. thus following trick is needed in EDR when
> double reporting (hot removal interrupt && dpc notification) is hit.

Please provide more detailed information about the hardware and BIOS
affected by this.


> -static void dpc_handle_surprise_removal(struct pci_dev *pdev)
> +bool  dpc_handle_surprise_removal(struct pci_dev *pdev)
>  {
> +	if (!dpc_is_surprise_removal(pdev))
> +		return false;

This change of moving dpc_is_surprise_removal() into
dpc_handle_surprise_removal() seems unrelated to the problem at hand.

Please drop it if it's unnecessary to fix the issue.


> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -184,6 +184,9 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>  		goto send_ost;
>  	}
>  
> +	if (dpc_handle_surprise_removal(edev))
> +		goto send_ost;
> +
>  	dpc_process_error(edev);
>  	pci_aer_raw_clear_status(edev);

This seems to be the only necessary change.  Please reduce the
patch to contain only it and no other refactoring.

Please capitalize the "PCI/EDR: " prefix in the subject and add
a Fixes tag.

Thanks,

Lukas

