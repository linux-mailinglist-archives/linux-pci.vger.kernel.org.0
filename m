Return-Path: <linux-pci+bounces-14331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDE799A733
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 17:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F41F23F29
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7440C18E02D;
	Fri, 11 Oct 2024 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDDPo5U4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464AE39FD6;
	Fri, 11 Oct 2024 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659324; cv=none; b=L+z3CmLqeEg9mPiT1Tih95eOxU+j6b5gFOfqCYJhGntudk7BXFKFsEGaA5/tLLVxmPLwiQCewBIV1RIgrbMR9X6VI4Qk+anOmO9PwGhbET/pVg0aHg11T1ATpCDHC6JlynInEJxUw2NlRWwk5gYFPYADVaCqL2RwFWvQesSoZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659324; c=relaxed/simple;
	bh=OXNIeY2jmKiNiddyfHGuzLJT8ksfjFgfQ0F71XsfjZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tknAMlhhCyqHucvZr+kfSpheOe+TBwpwOZccVFEx7JJW+L5gExMjpNOuL2xFV7w7unEt+VU6Q67SKjGWofvyeWts5Fxf7YYcUR1L1Pjo3J14+QgswAmDwpQvDhn57QxxSjsOdm62Nj4VUU6vS5HEapEOQjnxtraNNRJ673JWN8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDDPo5U4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0422C4CEC3;
	Fri, 11 Oct 2024 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728659323;
	bh=OXNIeY2jmKiNiddyfHGuzLJT8ksfjFgfQ0F71XsfjZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aDDPo5U4AZU7A0GPMDSAUb3FxRtdLJEFKTqCPXihrcvlLnGiZ/yQhzCfnrDtOxqpW
	 y5Y9E0II5u9JB03kXSFDCrqMl4ca/DV7sBdUxKAMxfEuIoH/i0mskoOkcGJgSSSWqY
	 8UoU1Eset25CeDHq0nded3fwmqDiw45P1SsQkbvX56WOVZpnUw07S0IHLfawBX1J3T
	 M8fgMzupJzpSxN8NBjKd/WwFv1/HKVfeSt6maEHUoH4P8iVox/0LciQtvU3smFGQZH
	 62izf8OKl/Z1Ph/3r1yLlN2h29T5ODEMOZ//ysW/UU40HWMfGmgO97pkNodyNFT/nl
	 GuyFs6BnBsw9A==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398e53ca28so2393757e87.3;
        Fri, 11 Oct 2024 08:08:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUA7FewFtHQL+3Fhi5ErTpD/CiluK8T51/kvWK/eYJrMIfSvtRTX+JUHuz4v3ioQZdG5bJ3aTY2VOhS@vger.kernel.org, AJvYcCXQfef803XoM8zq6C/AnHVWJiRRDK8pjvH5jlw63T3G0HYc7LiunpT+qVddvarbMsT6Cl+G/DpDCA3C@vger.kernel.org, AJvYcCXznIRlzHsS/PUo3FvZeeivHXvC3e5/L7uxqteaEEiPqoLmVAYXr+UkSXEH7eOrEICaCljZAGquqS752DNG@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYF4scZEqEVNPy82vESNxDLovq2cnJsT4bt+L4Z+d/qCheacO
	1a7iI/iviG1KGMxDao7zWU91kSAYV4TQeytPlWmDMas5h8RT2zKuS+8fRlmMvAnPxBRBsfGO2dF
	5FP4dhN1DwMnkS7XhRgZH06DBag==
X-Google-Smtp-Source: AGHT+IGVkF5FqO/p3mYjr/DByXYaEyjmAlop+EigrX0nEx+w399oEJruUdxGOBo5YLjLkZi/b7920j4LFpCRAfk50SA=
X-Received: by 2002:a05:6512:2810:b0:539:8af8:159b with SMTP id
 2adb3069b0e04-539da4d6686mr1695684e87.34.1728659322259; Fri, 11 Oct 2024
 08:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
 <20241010-dt-const-v1-2-87a51f558425@kernel.org> <cnow7dcfcevhlstodpbyghdsqytygcarsbonwv5qjgfou6hukf@p525rdpumr2d>
In-Reply-To: <cnow7dcfcevhlstodpbyghdsqytygcarsbonwv5qjgfou6hukf@p525rdpumr2d>
From: Rob Herring <robh@kernel.org>
Date: Fri, 11 Oct 2024 10:08:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLUPaKJ702bgOMqZgkB9AB5jNXYVUQgV9w3OxTbVaoc0A@mail.gmail.com>
Message-ID: <CAL_JsqLUPaKJ702bgOMqZgkB9AB5jNXYVUQgV9w3OxTbVaoc0A@mail.gmail.com>
Subject: Re: [PATCH 2/7] logic_pio: Constify fwnode_handle
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 9:59=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Thu, Oct 10, 2024 at 11:27:15AM -0500, Rob Herring (Arm) wrote:
> > The fwnode_handle passed into find_io_range_by_fwnode() and
> > logic_pio_trans_hwaddr() are not modified, so make them const.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > Please ack and I'll take with the rest of the series.
>
> Now I see. This one should be before #1.

Yes, you are right. Will swap 1 and 2 when applying.

Rob

