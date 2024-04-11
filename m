Return-Path: <linux-pci+bounces-6148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 173848A1E6F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 20:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0ECA1F27EF2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 18:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3714DA05;
	Thu, 11 Apr 2024 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0lHbVTl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B664D9FB;
	Thu, 11 Apr 2024 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858880; cv=none; b=sCf+zslAlzo6+G0vC/6jmj92bByXvxili98Us8szc0D/wbGy0R4c2Oh7rOoNwBJ9jrfejwuBblTXddMzAOjwAeTM20okRGzoNOH7WF2Tz9BTh9MUreMTDiBaucIAKUfZ6l5mxTOayYK9DeG4UIhkO6YWpeC5RfxFF4rg7cxX2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858880; c=relaxed/simple;
	bh=9LOswVCWQZaj0GPsvsmuK0XTcZ/qcpZUogLvUD1qfRk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cBmbL/K58id7TNDEgtjlwDbpOWN4FbcVTQTliiYbtT8PV6LSMFFKEL0iN1+VfWYcHGVVEz/leJ59oXL6wQ9bN1vEincRgyjj4hc0IEL4fBxW6SsMvu05PRjqoQ+c3XUZMF78tAAJrY3sd40YRNk3bQye3S/lgiGcPx6jVXEQplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0lHbVTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF235C072AA;
	Thu, 11 Apr 2024 18:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712858879;
	bh=9LOswVCWQZaj0GPsvsmuK0XTcZ/qcpZUogLvUD1qfRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=K0lHbVTlovwDDM+cENVEHLp3tIG7DFb8Ily6SWhFV+YaK+TBbCanrwhO+mxsGpOEI
	 FIbdw0dxJFoCVALzNSz683gT0Erx1F5diL1GPXLtPMdy/8Oa1D/J7UpJwNLIKBJmvQ
	 XcJ/xt97YFbfZ90FBFi3sR5tWpIJgPgeo6QMIZ3RJEu+uNmDINGp3wuOXiRvWCCS8I
	 MucQohQzt4rAL7q+fM/SM7QvXZM5AC+7LKy7CEh5OujX4lss1iKQjFA19w8RFP16iA
	 C+tsUqMX8ycCfULLg+T5EeG/0rpd5fAAhxi7/+WSesjFjDQ5PQ4q32krTVSURUNAXw
	 tQqK4Z2S3ZX5g==
Date: Thu, 11 Apr 2024 13:07:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ashok.raj@intel.com,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v18 10/11] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
Message-ID: <20240411180757.GA2190937@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f91fe6d25c13f9d2255d2ce97ca15be307e1bb.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>

On Mon, Mar 23, 2020 at 05:26:07PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Error Disconnect Recover (EDR) is a feature that allows ACPI firmware to
> notify OSPM that a device has been disconnected due to an error condition
> (ACPI v6.3, sec 5.6.6).  OSPM advertises its support for EDR on PCI devices
> via _OSC (see [1], sec 4.5.1, table 4-4).  The OSPM EDR notify handler
> should invalidate software state associated with disconnected devices and
> may attempt to recover them.  OSPM communicates the status of recovery to
> the firmware via _OST (sec 6.3.5.2).
> 
> For PCIe, firmware may use Downstream Port Containment (DPC) to support
> EDR.  Per [1], sec 4.5.1, table 4-6, even if firmware has retained control
> of DPC, OSPM may read/write DPC control and status registers during the EDR
> notification processing window, i.e., from the time it receives an EDR
> notification until it clears the DPC Trigger Status.
> 
> Note that per [1], sec 4.5.1 and 4.5.2.4,
> 
>   1. If the OS supports EDR, it should advertise that to firmware by
>      setting OSC_PCI_EDR_SUPPORT in _OSC Support.
> 
>   2. If the OS sets OSC_PCI_EXPRESS_DPC_CONTROL in _OSC Control to request
>      control of the DPC capability, it must also set OSC_PCI_EDR_SUPPORT in
>      _OSC Support.
> 
> Add an EDR notify handler to attempt recovery.
> 
> [1] Downstream Port Containment Related Enhancements ECN, Jan 28, 2019,
>     affecting PCI Firmware Specification, Rev. 3.2
>     https://members.pcisig.com/wg/PCI-SIG/document/12888

> +static int acpi_enable_dpc(struct pci_dev *pdev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +	union acpi_object *obj, argv4, req;
> +	int status;
> +
> +	/*
> +	 * Some firmware implementations will return default values for
> +	 * unsupported _DSM calls. So checking acpi_evaluate_dsm() return
> +	 * value for NULL condition is not a complete method for finding
> +	 * whether given _DSM function is supported or not. So use
> +	 * explicit func 0 call to find whether given _DSM function is
> +	 * supported or not.
> +	 */
> +        status = acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> +				1ULL << EDR_PORT_DPC_ENABLE_DSM);
> +        if (!status)
> +                return 0;
> +
> +	status = 0;
> +	req.type = ACPI_TYPE_INTEGER;
> +	req.integer.value = 1;
> +
> +	argv4.type = ACPI_TYPE_PACKAGE;
> +	argv4.package.count = 1;
> +	argv4.package.elements = &req;
> +
> +	/*
> +	 * Per Downstream Port Containment Related Enhancements ECN to PCI
> +	 * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
> +	 * optional.  Return success if it's not implemented.
> +	 */
> +	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> +				EDR_PORT_DPC_ENABLE_DSM, &argv4);

This has been upstream for a while, just a follow-up question: this
_DSM function was defined by the ECN with Rev 5.  The ECN was
incorporated into the PCI Firmware spec r3.3 with slightly different
behavior as Rev 6.

The main differences are:

  ECN
    - Rev 5
    - Arg3 is an Integer
    - Return is 0 (DPC disabled) or 1 (DPC enabled)

  r3.3 spec
    - Rev 6
    - Arg3 is a Package of one Integer
    - Return is 0 (DPC disabled, Hot-Plug Surprise may be set), 1 (DPC
      enabled, Hot-Plug Surprise may be cleared), or 2 (failure)

So the question is whether this actually implements Rev 5 or Rev 6?
It looks like this builds a *package* for Arg3 (which would correspond
to Rev 6), but we're evaluating Rev 5, which specified an Integer.

The meaning of the Arg3 values is basically the same, so I don't see
an issue there, but it looks like if a platform implemented Rev 5
according to the ECN to take a bare Integer, this might not work
correctly.

> +	if (!obj)
> +		return 0;
> +
> +	if (obj->type != ACPI_TYPE_INTEGER) {
> +		pci_err(pdev, FW_BUG "Enable DPC _DSM returned non integer\n");
> +		status = -EIO;
> +	}
> +
> +	if (obj->integer.value != 1) {
> +		pci_err(pdev, "Enable DPC _DSM failed to enable DPC\n");
> +		status = -EIO;
> +	}
> +
> +	ACPI_FREE(obj);
> +
> +	return status;
> +}

