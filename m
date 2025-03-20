Return-Path: <linux-pci+bounces-24212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF6A6A155
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F06D1894980
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D587211299;
	Thu, 20 Mar 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVcVaYV2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C343220F070
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459304; cv=none; b=Z2xC+yI+5oBJx7PCRsCPRTTbVu0C4LCLiKzgrm29SKs6qI+uB6TSKiPMaWuvfANxRI70lOUGdKTg5mpoVK6sgCyZDDhozXYoZjJpl4kjfwpdyBWv6K97shrcyRxRlo/DQua6tMdNt7cZ/iFMhBSL056esCfEWFpSm68z3ss1oYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459304; c=relaxed/simple;
	bh=9iRhKQvC51ISRCoTsWHbZEPd+v7VDn2vLrGduepW1rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lT7ZfW3agitNgLpPXzKmZqAdhf8tOFw5iFKjTDcAdoIsQW9PUJKMbf+xDKp3kxsSq3uu6Ntr60lLUfCepU4kdqUflnk5Ut7ui516mRp8APPlg6HDiYsvRnrWhIS3d3lAPiB0oIv8+Nb6H3IIBibwcfuf5a91cIIxX+Bzrugd78c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVcVaYV2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so841760a12.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459301; x=1743064101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iRhKQvC51ISRCoTsWHbZEPd+v7VDn2vLrGduepW1rk=;
        b=iVcVaYV2fgAXreQrhFE07z4hmCYQTEpnLvEt4qa1eCNlKMyagIvcjsRgKI2NZtbrZa
         5L4lC3utz/pvAu2hBEh74Ez4PeJWzIT+ZVAqGT/Yx/KlJn6KSlX86tfGvQMnjahUb5dI
         i0nhAojghfB3HKEAY2CQZahz1xOw8c9doqyT38pDkIcS753AnubqC5hL/RWw2Vz3tYCL
         ImHiX3kMGotmFk2Yc67FtE4g8YiCdZmnrqWL/xWHSB7QA0lraTmqbl4ZasJcCtDAA4bL
         aEdCLd1RSGrNxN2Y5ZICEjo/Kcl5ryIetCSUnCS45CYwM18vd/3B0WflIc+h9fUvlhWN
         JYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459301; x=1743064101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iRhKQvC51ISRCoTsWHbZEPd+v7VDn2vLrGduepW1rk=;
        b=nLkIJ2RNBmRVJ1SdTi/SK+EoqTKfUzj04FSA+s/bJvFhhSlyGoavYpY1Jt4UJKuEBe
         CQ8YsIipDOci2FRSzt6TMeCXNq5YIPhLLu1flZfKddCxZtO9oaclKp9chzVW7AP+lzaH
         v6cApyx8XU+xESohZexdjaRQCURyyCjJAgAN+A9TnqbbqXvW4C+q7Rles9eoo75RvKMk
         pWEEtBvLVITzsHKQyg+2aJedwKgd8ui5yJoUOcvGkTHCQvviMsV/YEJXcueqKgc81/X7
         /ycfcX6JE5IijmbolvpNkTZK6rpLnu4C3z1tkM56DPPObbXK/goZdESr0tmlwnIk7yGu
         x2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJeMIzqJ+U+qeu/qAHv9Uj548jLzOS+yUPjPpnHnHD+3eAcbA3RL7X1DuMlp3FgQRhUu2I0OruqAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIiiZyMaFJYF+mahYaqbdUnxLUQqhT3BhBDawrsqJ6bb8b1SH/
	BJEkYx13dS+dJEMp47hObkI9/F84aDCgzAoA4BTjiZat1NjJd8ed32x0IbpPIk29X9KW/fzPSuz
	UK00K75QSVIxTcCAYx+g1eMyfkC4S+fxZMKQ2
X-Gm-Gg: ASbGncuH2B6petm4UZe3o9W56F1dCNklmpqdiMq8950hIamOLBwz185kHhVZjGtmIa8
	EEmWc1chTv4/6XH3THUpXnTfqwgwm+KbWWPvRCOP5JdgOOYNdoHYA3SjZYUQUfIfGD1gBUlH9uY
	ALUPx3E8kt2yeqTFobS0IrDYY=
X-Google-Smtp-Source: AGHT+IHDrFIwLG0vcFsLPTAnd6JPjI7+SzaHRhsNayMUGuyMJ3SfAfwt7lCMBe7DdXFXHXCj8K35Ogq6fMf+YPFHXVI=
X-Received: by 2002:a05:6402:5194:b0:5dc:9589:9f64 with SMTP id
 4fb4d7f45d1cf-5eb80cfc810mr6094227a12.13.1742459300914; Thu, 20 Mar 2025
 01:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com> <20250319084050.366718-5-pandoh@google.com>
 <8e0a2c15-f26d-451d-b91d-bc7b8029a9af@linux.intel.com>
In-Reply-To: <8e0a2c15-f26d-451d-b91d-bc7b8029a9af@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 01:28:10 -0700
X-Gm-Features: AQ5f1JoOPW4_Bj_DxT5_MoSnnqRy8f0inm95t1Eix4MipckZuMEjrL8l3Bt_xTs
Message-ID: <CAMC_AXV2BSYsPwgO=a6_JP7Lq--H9wANaLu5jAfZF_dCYPTcoQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] PCI/AER: Rename struct aer_stats to aer_report
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 8:29=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> On 3/19/25 1:40 AM, Jon Pan-Doh wrote:
> > -/* AER stats for the device */
> > -struct aer_stats {
> > +/* AER report for the device */
> > +struct aer_report {
>
> This struct only seems to have details related to AER error status. Why
> rename
> it to aer_report() ? Are you extending it in future patches? If yes,
> include that
> motivation in the commit log.

Karolina suggested aer_report[1] as a more suitable name than the
previously proposed aer_info. aer_stats is no longer suitable as the
struct contains more than just error counters (e.g. ratelimits).

I did not have a plan on extending it (other than maybe adding
ratelimits for IRQs in a follow-up series) at this time.

Do you have an alternative suggestion instead of aer_report?

[1] https://lore.kernel.org/linux-pci/12d24891-c32e-4a84-a6ee-4501106a6957@=
oracle.com/

Thanks,
Jon

