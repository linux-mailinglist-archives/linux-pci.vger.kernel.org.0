Return-Path: <linux-pci+bounces-22465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69968A46DFC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 22:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A567A7BB2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 21:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938BD265CBD;
	Wed, 26 Feb 2025 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEtlYjj1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF7523A9AE
	for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607124; cv=none; b=iwrArTaI5Mqd2LnymitAHFqzPJLJ8+Rbsgj0fueT+OJ8add6VH0WCoIFy+B6K3bJoVnODkhjW5YnNyfshaW8OuGIOuNTQWvIhHk0A9cAS25kcaX9MUZUJVOwZLYGdgjubHoCVBYqPbfole66eu9ZPgM8MN+lOdf+vpfV/yx/jVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607124; c=relaxed/simple;
	bh=dGVQwofA2mF3rCKefgJ6shQpUqK/R0gqUE4OsUCwJis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g8sP4hQUclqv9pDTHfaSkO6g9HCJrkjRJjv/iwrxrwzMIA4GSy6fixdojbrPV8eZ+p8JtJRsK3Rb0uIGBB7yvRQwOnmjwnuCL/y/v2Aa70ofppUbNqzbXNCiQ3MrHxsqN6kkSbrXIcDAb+k6v2jguUFH7VTWSn7r41ENS0CseDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEtlYjj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB06EC4CED6;
	Wed, 26 Feb 2025 21:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740607123;
	bh=dGVQwofA2mF3rCKefgJ6shQpUqK/R0gqUE4OsUCwJis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TEtlYjj1OZQCmUcSCvOaivbTUHKz9geYajadS3yxe94LJMVyvSHSFEC1feWpPa4HY
	 cOwxr4QLepMbzplAFtAY+uXikfJdJ/lXWJWotY+dZuX4MQ8OCByj/F8s/97X9NXoS8
	 sohIG5ahZiceFKwaXSqoXKzAcFVOJtiGyjneMrRmrtsYfiSbPTQC5qegBuQl90+989
	 b09DTsBapvTxLrBMhKFF/mslrn9GUOpyYLp7QyhbyEJKEgtkgQuo8Qe+Ax5oC+5TQK
	 pUN7AS0hq9OptVcuWPTLIvqF4D2CVwuaBDt7FLwKoa+YI1rzWQnTJ0z7PVrdJwZT4H
	 dy+BXWrIMTDiQ==
Date: Wed, 26 Feb 2025 15:58:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>
Subject: Re: Regression on linux-next (next-20250221)
Message-ID: <20250226215842.GA560520@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB6129B4B298158496F8BD36B0B9C22@SJ1PR11MB6129.namprd11.prod.outlook.com>

On Wed, Feb 26, 2025 at 07:36:19PM +0000, Borah, Chaitanya Kumar wrote:
> Hello Bjorn,
> 
> Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
> 
> This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.
> 
> Since the version next-20250221 [2], we are seeing that some of the machines in our CI are unable to connect through ssh (and therefore unable to participate).
> Looking at the logs we see this.
> 
> `````````````````````````````````````````````````````````````````````````````````
> [    5.838496] e1000e: Intel(R) PRO/1000 Network Driver
> [    5.838515] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    5.838737] e1000e 0000:01:00.0: Disabling ASPM  L1
> [    5.840055] e1000e 0000:01:00.0: probe with driver e1000e failed with error -12
> `````````````````````````````````````````````````````````````````````````````````
> After bisecting the tree, the following patch [3] seems to be the first "bad"
> commit
> 
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> commit 7d90d8d2bb1bfff8b33acbb6f815cba6f5250fad
> Author: Bjorn Helgaas mailto:bhelgaas@google.com
> Date:   Fri Feb 14 18:03:00 2025 -0600
> 
>     PCI: Avoid pointless capability searches
> 
>     Many of the save/restore functions in the pci_save_state() and
>     pci_restore_state() paths depend on both a PCI capability of the device and
>     a pci_cap_saved_state structure to hold the configuration data, and they
>     skip the operation if either is missing.
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> 
> We verified that if we revert the patch the issue is not seen.

Sorry about this; this patch was dropped in next-20250224

Bjorn

