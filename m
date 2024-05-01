Return-Path: <linux-pci+bounces-6974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D58B9065
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 22:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B411F23AEE
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 20:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC4D161933;
	Wed,  1 May 2024 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWQ0wY9N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3A16191E;
	Wed,  1 May 2024 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594025; cv=none; b=CNWLoHi44dpG6kViWZs56cCEJvSh0OsN+gRvdWZBOikFjjaXZclGthpFjTp3dLa6LahZL7HHsbxmcsVaZqnAMxKGVkON/RKC09w0VEB9q/NslSrSc9iD7C7LqmZXQgmXfTqbYzJcjFQjTpDI8YOIJg4hQI3FXUFVpTx5+FCpx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594025; c=relaxed/simple;
	bh=V/K9SYCQMalXsilBTuDB5HWAA77CoQ8l41FBGzMkUl4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WlwKp9eLO1KV0naZDvo/OehinpyJVXalZeXW3cR1BZDGruEGT9AYdEE+hLmE2VNKXjGyaEMnz1O+PRmVWsONbOllkYt9ryuXVZf4a2oLE2uY6Ga4JUeOGQZ5NMM/Dw5meKgpxhxTZfffROu5SjS2Hotg4i3cc7HifYdvjvj7sjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWQ0wY9N; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714594023; x=1746130023;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=V/K9SYCQMalXsilBTuDB5HWAA77CoQ8l41FBGzMkUl4=;
  b=CWQ0wY9NRqBzFCI/Y+pa6HFa2ycU5LaAvPUN8aiuVEbSKDc266/7FMs5
   o6rHb17/lI0wIRRTYEQDhO0Ie8vtgl87zUuzWZ6ips7IFnqOgTNnsBmjG
   vDA+4/SfcQNYesxud7uEYmJOOLjkXgUIQdJpQCvaQluw9Ar1WaU+UCr/S
   iEMM9mTSLFK9E8LDAiCGsE6TQ62gTSg0UVzdXmQx8E08P5YnmdhjS6ERJ
   VuW+wMctRFTtuegFaEhKX9wvgBgNWie0a87EkThyFoavq4aLPPWfo9UxK
   XOEaOap/BvqNqOVgHPT9BsKhfQ83MlZyYFYrQUHlOnu3Bki1aLPUFpf1C
   Q==;
X-CSE-ConnectionGUID: MwFtOnWwREicsMqXajVZ6A==
X-CSE-MsgGUID: tKeHS10mR2iMNxrX9P+4qQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="21028252"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="21028252"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 13:07:02 -0700
X-CSE-ConnectionGUID: ntLDZ+aGQze2UbSSB060Mg==
X-CSE-MsgGUID: AwZBiScgSkG2SHIqrAufvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="31581495"
Received: from pgateley-mobl1.amr.corp.intel.com ([10.212.209.203])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 13:07:02 -0700
Message-ID: <e84ba9a250615de2f39600160ad0577f2d5caf94.camel@linux.intel.com>
Subject: Re: [PATCH] PCI/ASPM: Clarify that pcie_aspm=off means leave ASPM
 untouched
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Vidya Sagar <vidyas@nvidia.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Maciej W . Rozycki" <macro@orcam.me.uk>, 
 Johan Hovold <johan+linaro@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Ajay Agarwal <ajayagarwal@google.com>,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 01 May 2024 13:07:01 -0700
In-Reply-To: <20240429191821.691726-1-helgaas@kernel.org>
References: <20240429191821.691726-1-helgaas@kernel.org>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTA0LTI5IGF0IDE0OjE4IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOgo+
IEZyb206IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+Cj4gCj4gUHJldmlvdXNs
eSB3ZSBjbGFpbWVkICJwY2llX2FzcG09b2ZmIiBtZWFudCB0aGF0IEFTUE0gd291bGQgYmUgZGlz
YWJsZWQsCj4gd2hpY2ggaXMgd3JvbmcuCj4gCj4gQ29ycmVjdCB0aGlzIHRvIHNheSB0aGF0IHdp
dGggInBjaWVfYXNwbT1vZmYiLCBMaW51eCBkb2Vzbid0IHRvdWNoIGFueSBBU1BNCj4gY29uZmln
dXJhdGlvbiBhdCBhbGwuwqAgQVNQTSBtYXkgaGF2ZSBiZWVuIGVuYWJsZWQgYnkgZmlybXdhcmUs
IGFuZCB0aGF0Cj4gd2lsbCBiZSBsZWZ0IHVuY2hhbmdlZC7CoCBTZWUgImFzcG1fc3VwcG9ydF9l
bmFibGVkIi4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29n
bGUuY29tPgoKTEdUTS4KClJldmlld2VkLWJ5OiBEYXZpZCBFLiBCb3ggPGRhdmlkLmUuYm94QGxp
bnV4LmludGVsLmNvbT4KCj4gLS0tCj4gwqBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5l
bC1wYXJhbWV0ZXJzLnR4dCB8IDUgKysrLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRt
aW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0Cj4gYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1
aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dAo+IGluZGV4IGJiODg0YzE0YjJmNi4uNGJjMjgxZDZl
OGQzIDEwMDY0NAo+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFt
ZXRlcnMudHh0Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1l
dGVycy50eHQKPiBAQCAtNDU5MCw5ICs0NTkwLDEwIEBACj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBub3JpZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBbUzM5MF0gaWdub3JlIHRoZSBS
SUQgZmllbGQgYW5kIGZvcmNlIHVzZSBvZgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvbmUgUENJIGRvbWFpbiBwZXIgUENJ
IGZ1bmN0aW9uCj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBwY2llX2FzcG09wqDCoMKgwqDCoMKgW1BD
SUVdIEZvcmNpYmx5IGVuYWJsZSBvciBkaXNhYmxlIFBDSWUgQWN0aXZlIFN0YXRlCj4gUG93ZXIK
PiArwqDCoMKgwqDCoMKgwqBwY2llX2FzcG09wqDCoMKgwqDCoMKgW1BDSUVdIEZvcmNpYmx5IGVu
YWJsZSBvciBpZ25vcmUgUENJZSBBY3RpdmUgU3RhdGUKPiBQb3dlcgo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1hbmFnZW1lbnQuCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9mZsKgwqDCoMKgwqBEaXNhYmxlIEFTUE0uCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9mZsKgwqDCoMKgwqBEb24ndCB0b3VjaCBBU1BNIGNv
bmZpZ3VyYXRpb24gYXQgYWxsLsKgIExlYXZlIGFueQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29uZmlndXJhdGlvbiBkb25lIGJ5IGZpcm13YXJlIHVu
Y2hhbmdlZC4KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZvcmNlwqDCoMKgRW5h
YmxlIEFTUE0gZXZlbiBvbiBkZXZpY2VzIHRoYXQgY2xhaW0gbm90IHRvIHN1cHBvcnQKPiBpdC4K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBXQVJOSU5H
OiBGb3JjaW5nIEFTUE0gb24gbWF5IGNhdXNlIHN5c3RlbSBsb2NrdXBzLgo+IMKgCgo=


