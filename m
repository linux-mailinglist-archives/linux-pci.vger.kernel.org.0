Return-Path: <linux-pci+bounces-45307-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIHWL7LQb2mgMQAAu9opvQ
	(envelope-from <linux-pci+bounces-45307-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 20:00:02 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3371549EF9
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 20:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE2347EE72C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 18:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9454239C651;
	Tue, 20 Jan 2026 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAdGIP/6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACDF316180;
	Tue, 20 Jan 2026 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932836; cv=none; b=KQQmk5FuITrjJa+VNSUL4u7q2pP5BFeNMYTDntdfZDqDQVQT1aib2qZ2kZCz62eFRtj9XBMCsBiMCGyg3N1iHEa++kd/EaH0p7TffJyW086xefdGifzX2yrxLbs1c0GDeSeAKxpA0Cx4H1qxhRN6X/nbDrEu2zNkwKr8PQQxTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932836; c=relaxed/simple;
	bh=GZGlrckUb+X6DeKFq+2HExBoXrTDSQ3yJcPYM+hMIp0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f50UVZioP+q/GjASrGUWbnblrgp0pdjQpxtrzfVmQgRRicJaM3IxasQPvPtWiE53c4bzer5FIqB6oSRr8afnh3m2QuiQLmsU6Ne3DiD+IFz7dh0rU4MN3AYI5/9K8FVx6SttPKjPFYvAK1G6wGiK5BWKD+I0tcv7QDabYxfwvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAdGIP/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB51C19421;
	Tue, 20 Jan 2026 18:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768932836;
	bh=GZGlrckUb+X6DeKFq+2HExBoXrTDSQ3yJcPYM+hMIp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hAdGIP/6cI5SwPjtJ+namRDM9kEjhSLv6zc/N7Oze272DJXPQ0DjzDUtmCgA4l5wb
	 +SoZPuXGLp53g0pJI8FDW8gmkG877Ga24WvHKbM4CRgzDI0R4OkleVvLbzYrm3I+4r
	 /Hh9LDe+GWk8jNjz/Divri+fY8HSZ4gqmjUmAUb2qbhBKDeM5zzwVdc6kUXiPQAzeV
	 CWfGKrgVSlgB9xLI2LmQuXmlfvnp2M+aE5FwKT1tbD3fGQnbOoEzHl5GCwq6g93c9P
	 Ap0czXiVcgq2uEWVCIGML6mDSqBobIDNBgMfGMVnHVesNz4lg+YDfPjjs/GxGVip/M
	 J2O1nGzeG89mA==
Date: Tue, 20 Jan 2026 12:13:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.de,
	bhelgaas@google.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	linux-kernel@vger.kernel.org, kw@linux.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: pci_ids: Add Intel Nova Lake audio Device ID
Message-ID: <20260120181354.GA1159968@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120083148.12063-2-peter.ujfalusi@linux.intel.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-45307-lists,linux-pci=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.de,google.com,vger.kernel.org,linux.intel.com,linux.dev,linux.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-pci@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pci];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 3371549EF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 10:31:45AM +0200, Peter Ujfalusi wrote:
> Add Nova Lake (NVL) audio Device ID
> 
> The ID will be used by HDA legacy, SOF audio stack and the driver
> to determine which audio stack should be used (intel-dsp-config).
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

"git log --oneline include/linux/pci_ids.h" says "pci_ids" in the
subject is unnecessary.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 84b830036fb4..5ed7846639bf 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3144,6 +3144,7 @@
>  #define PCI_DEVICE_ID_INTEL_HDA_CML_S	0xa3f0
>  #define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
>  #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
> +#define PCI_DEVICE_ID_INTEL_HDA_NVL	0xd328
>  #define PCI_DEVICE_ID_INTEL_HDA_BMG	0xe2f7
>  #define PCI_DEVICE_ID_INTEL_HDA_PTL_H	0xe328
>  #define PCI_DEVICE_ID_INTEL_HDA_PTL	0xe428
> -- 
> 2.52.0
> 

