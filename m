Return-Path: <linux-pci+bounces-24389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6234AA6C2AE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 19:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199D21B63024
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 18:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85AE1EB9E1;
	Fri, 21 Mar 2025 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3mD72Qn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1086622F395
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742582479; cv=none; b=olq3QRswM2QHUSF6gYhnDlcaqA5D8RW4jCLR6uyMyoG0hrNa1bfG7Hq2HmyHkpifyJz2eNGhCoEyfi9qZ6PGRZ9R/xuvJikF0ejyvqJwCk9fCc2ghkJFYQTnzDwA90oajd28khCns0llRLF/zK/LinL3tv4/wOL7i04Y6THflIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742582479; c=relaxed/simple;
	bh=ySYR74zSQmJCdmta8A2rVRGqDs+nXMgr0M4g19WZE/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruix6dnpIsLCeEIqmFkey47xsmjfVPtZfTqmP9MCx9cAY4ZNdYkowIPDSXlrm2fpDIfE2X+vR6RJFnihJ2aLohzp0UfwffcUKmwEjKlOX9K6VTv6zjE0S0PH2SI0QCce/HQ+Iy3E/S9hsn9xBiD2nUktBdDfFh8p3HE/IUi5idk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u3mD72Qn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso4050342a12.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 11:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742582475; x=1743187275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfeAszGUjaAPFD0R+uo2uM06RMF7HeplZLPhdeGePc8=;
        b=u3mD72QnGe96gR5qnduvfCOoMqTsJhZx70Ni7TSOhMhcidGQHhhIzRDUEn92WieNod
         7PLgh717y+EQMmZ0ss54Is2sQd3IZgO0adme52JDUjemXAW0rlB7Eccbkwgbp4THlUvV
         dwuMY+KUdpYaB2CtN8VDpZ4lDPjzjYjRtKqNTNjeFexW937+bWJq3jdObZaSiH2cn2xW
         SpzriFaEmtGEidF3AtsZmn0TZhmKqNTOHLoIzIruZ9RsIHuP2Yfrfz7WGm+RyFTtDRKK
         xCcUCjMinDqLmWhK+mp1l2Yq2Jvprd/BbVix76AB57HCc8MNOh4IL56QHzz6SFhD0CSM
         v+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742582475; x=1743187275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfeAszGUjaAPFD0R+uo2uM06RMF7HeplZLPhdeGePc8=;
        b=ojUtmvqQBJj9IbsfB+ocg/YJ23/IYAJCMOq+23wNQd4pH+SyzL79+/lTuWKhebKAoz
         YDeX0hzI7NvkYg7EfyklvqEJ+bkwAiMgA7KAb7LAAND0kP4vmrf0j+A2zJAsSzkmh97M
         2Afhk3017vieotW5ePC3szuK8bUtamiDnRw2L96vVy/xMovItjN5RZ8+nLaTqfSXDu2G
         wbE0ceNq8kkZ7F8RxfHF/2yBnvzt69vOXZ1SnGgM2TKldTkWF/ZYeYh0bEWtfXeI5BlK
         DrzBqsAdOXPvJZMXT+IwgpF8pf8CplsusbED6QRFa2IGPLMbfdAmRU8oPBMaG250JA++
         J1gg==
X-Gm-Message-State: AOJu0YxhkL83dqeBMOwklZyHK2icFsr4YDJDmgcVHwIPJHQOM11YuQZo
	jRaBFav3ZnbQvOCnA2v5RCF46RxQge8Z3AEYQDU/68Zwh1rLofIeABXvuSubqgSpNFXzyaSEmnx
	W36ALyxukkU9+USOdeu6JJ7YNyQjjTZ/lHoLr
X-Gm-Gg: ASbGncsi1a7yV2PPruqVPW88UfkDcWWNhjvHQ3uxBvujM5dzOaNwAFo2kZ2nTGRsJLd
	Vi/AHB97bmQ+vLW8fz2np/JzE8eJOkp+wp0iEB2Rn4oNjFXIMhSIRK871yd+Oyo0DPmRCF7w8y+
	hoaqql+LhbOtSlGCHHaHbULzeWQYEGo4bR1tJUZwB4Bys2FksznwYcxDW4rNxh/RTze/Y=
X-Google-Smtp-Source: AGHT+IF+la3XA91c697pmJFtpIpvVG3e2v/1UIAGT02/DFDxHFm1sPJgcLqaHYc+erT3I83nduABNK8C/BBiBDxa8Ow=
X-Received: by 2002:a05:6402:27d1:b0:5e4:d229:ad3d with SMTP id
 4fb4d7f45d1cf-5ebcd45caf5mr3828182a12.16.1742582475087; Fri, 21 Mar 2025
 11:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321015806.954866-1-pandoh@google.com> <20250321015806.954866-7-pandoh@google.com>
 <e028eed2-440d-4094-bbf4-016ae5c0acf0@oracle.com>
In-Reply-To: <e028eed2-440d-4094-bbf4-016ae5c0acf0@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 21 Mar 2025 11:41:04 -0700
X-Gm-Features: AQ5f1JoaviP9oyagVte9qQ9d8BIiFBGfO3idHWs6Rwh657KuShn20-KhmixgpQg
Message-ID: <CAMC_AXWSXLwnS7-KbK=xFR+r84s+VCYYEegBVFCqehx21L4AeA@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] PCI/AER: Introduce ratelimit for error logs
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sargun Dhillon <sargun@meta.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 6:46=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
>
> On 21/03/2025 02:58, Jon Pan-Doh wrote:
> >   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
> > -                  const char *level)
> > +                  const char *level, bool ratelimited)
>
> Ideally, we would like to be able to extract the "ratelimited" flag from
> the aer_err_info struct, with no need for extra parameters in this functi=
on.

I considered this, but pci_print_aer() and dpc_process_aer() both call
aer_print_error directly without populating info->dev[]. I thought it
was easier/cleaner to pass it in vs. populate info->dev[] and then
read it.

> (please correct me if I'm misreading the patch)
>
> It looks like we ratelimit the Root Port logs based on the source device
> that generated the message, and the actual errors in
> aer_process_err_devices() use their own ratelimits. As you noted in one
> of your emails, there might be the case where we report errors but
> there's no information about the Root Port that issued the interrupt
> we're handling.

Your understanding is correct. I think the edge case described is
acceptable behavior:

1. Multiple errors arrive where the first source device is ratelimited
2. Root port log and first source device log are not printed
3. Other error source device(s) logs are printed

The root port message is of the form:
<root port> (Multiple) <severity> error message received from <first
source device>

If the root port log is printed, this could cause confusion as:
- root port log mentions first source device only
- source device logs mention other source device(s) but not
ratelimited first source device

There's an argument that there is still value in the root port log as
you can infer that the subsequent source device logs are under that
same root port. I don't think it's that useful (biased as I advocated
for removing root port logs to begin with :))

> The way I understood the suggestion in 20250320202913.GA1097165@bhelgaas
> is that we evaluate the ratelimit of the Root Port or Downstream Port,
> save it in aer_err_info, and use it in aer_print_rp_info() and
> aer_print_error(). I'm worried that one noisy device under a Root Port
> could hit a ratelimit and hide everything else

This is not a 100% translation of Bjorn's suggestion as I share your
concern (1 spammy device ratelimits and hides other devices).

> A fair (and complicated) solution would be to check the ratelimits of
> all devices in the Error Message to see if there is at least one that
> can be reported. If so, use that ratelimit when printing both the Root
> Port info and the error details from that device.

I mentioned this as well[1], albeit briefly. I'd opt for this if my
initial solution isn't satisfactory. You could make it more
complicated by substituting the source device, if it is ratelimited,
to a non-ratelimited one. However, it's not good as it changes the
default expectation that the root port log would have the source ID.

[1] https://lore.kernel.org/linux-pci/CAMC_AXWQg53uNLsZizxEsOf_3C2gv=3DvBdA=
AeMek1AmnTnMmDAw@mail.gmail.com/

Thanks,
Jon

