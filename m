Return-Path: <linux-pci+bounces-43571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDF9CD90A3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 12:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0B3530019ED
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 11:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6320301474;
	Tue, 23 Dec 2025 11:12:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879EE28A1E6;
	Tue, 23 Dec 2025 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488335; cv=none; b=vElGtY2OFrnqm83Q/i/VgZR78GlaBOLGv3aNeGW8HGKa9W9JYQ3NPz6xNJ25KzLAjPbFaTa4Tdez1BuWKwmorjJ+UchzlVuJi0Ga0fpf09feUPjKmAJQsJ6nN3a8ZTOK/j/v4tYFbbumWPc7b+IpLSo1iunlrEOWZOkqJIO2zW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488335; c=relaxed/simple;
	bh=eDH5SH3C74f20IHQKIV+ZEM+AhPSBxC4WVYw50K30FY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hf+x6CRnnLEWcPJqgLlywdVf7XSTVpV1Y8oI8+gZPfR2nueHO2BkKFXQXMtpOdctmdF7oFR8ZcwlVCO9Sj+sfoK3TeCPIS7GkcDwKePQ0dH1wBWWFcsyUk+wom1dfQ+A46lPGwiJz0R6FP4+zKEA5Twu3DL5WwRySHvxSVRFu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dbC4h59pYzHnH6q;
	Tue, 23 Dec 2025 19:11:32 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9241D4056C;
	Tue, 23 Dec 2025 19:12:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 11:12:08 +0000
Date: Tue, 23 Dec 2025 11:12:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2.1 1/8] ACPI: bus: Fix handling of _OSC errors in
 acpi_run_osc()
Message-ID: <20251223111207.0000595d@huawei.com>
In-Reply-To: <3042649.e9J7NaK4W3@rafael.j.wysocki>
References: <2413407.ElGaqSPkdT@rafael.j.wysocki>
	<3042649.e9J7NaK4W3@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 22 Dec 2025 20:05:44 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The handling of _OSC errors in acpi_run_osc() is inconsistent and
> arguably not compliant with the _OSC definition (cf. Section 6.2.12 of
> ACPI 6.6 [1]).
> 
> Namely, if OSC_QUERY_ENABLE is not set in the capabilities buffer and
> any of the error bits are set in the _OSC return buffer, acpi_run_osc()
> returns an error code and the _OSC return buffer is discarded.  However,
> in that case, depending on what error bits are set, the return buffer
> may contain acknowledged bits for features that need to be controlled by
> the kernel going forward.
> 
> If the OSC_INVALID_UUID_ERROR bit is set, the request could not be
> processed at all and so in that particular case discarding the _OSC
> return buffer and returning an error is the right thing to do regardless
> of whether or not OSC_QUERY_ENABLE is set in the capabilities buffer.
> 
> If OSC_QUERY_ENABLE is set in the capabilities buffer and the
> OSC_REQUEST_ERROR or OSC_INVALID_REVISION_ERROR bits are set in the
> return buffer, acpi_run_osc() may return an error and discard the _OSC
> return buffer because in that case the platform configuration does not
> change.  However, if any of them is set in the return buffer when
> OSC_QUERY_ENABLE is not set in the capabilities buffer, the feature
> mask in the _OSC return buffer still representes a set of acknowleded

typo: represents

> features as per the _OSC definition:
> 
>  The platform acknowledges the Capabilities Buffer by returning a
>  buffer of DWORDs of the same length. Set bits indicate acknowledgment
>  that OSPM may take control of the capability and cleared bits indicate
>  that the platform either does not support the capability or that OSPM
>  may not assume control.
> 
> which is not conditional on the error bits being clear, so in that case,
> discarding the _OSC return buffer is questionable.  There is also no
> reason to return an error and discard the _OSC return buffer if the
> OSC_CAPABILITIES_MASK_ERROR bit is set in it, but printing diagnostic
> messages is appropriate when that happens with OSC_QUERY_ENABLE clear
> in the capabilities buffer.
> 
> Adress this issue by making acpi_run_osc() follow the rules outlined
> above.
> 
> Moreover, make acpi_run_osc() only take the defined _OSC error bits into
> account when checking _OSC errors.
> 
> Link: https://uefi.org/specs/ACPI/6.6/06_Device_Configuration.html#osc-operating-system-capabilities [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

