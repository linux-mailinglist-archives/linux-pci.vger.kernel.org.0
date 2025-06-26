Return-Path: <linux-pci+bounces-30819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83363AEA76B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 21:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629D97A60E7
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 19:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E4E2F0047;
	Thu, 26 Jun 2025 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoQ8oRIO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFBC2EFD96;
	Thu, 26 Jun 2025 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967609; cv=none; b=jC63GSvtRFUBxABIs5ittsY8vJHMdGvBnfOfceF3VbunBHooc5m4OkV0NqrGsFMc2BbVby/4wVzAeq4S7Hva1t+5gw4B+VfduLd8s2b5da3JDsh0PIYIDBa+oGOJvIpyn56PKGKxSvY5l9JhzkjfzbvCeyFUOd7eHkJlYxP4dZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967609; c=relaxed/simple;
	bh=zd6vb4QxveFon7B3CZSViiKsMHSBmEmxGp/d12jKjGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MStTwTafcuokTgPOAu2CGKVY7PNedaQmte4afd1IJL6SieHN7JUkQ0K6Uup0FuH9veZMrkD89Es0gGHV44ZGWgPNPfn9m2L/rvJVHBHBmVUcMWJQyfECGhzPh0whj6tp0U4tQX1e0tpkTs4Puf6c47Y63gauTf7jxL+staIPcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoQ8oRIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B05C4CEEB;
	Thu, 26 Jun 2025 19:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750967609;
	bh=zd6vb4QxveFon7B3CZSViiKsMHSBmEmxGp/d12jKjGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UoQ8oRIOtm6VaeYcXpyBVvBFlGAN+pwKhCsQgDUiDuggZCagscyw39521OUr7Pux2
	 ffn7FEqnSGLuCkb+V1BtIlowfA85y+EeXz9duCkBwsqMrjT7yHse4yb96qyOfEC/E0
	 d96M3QND/xmtaEb8HcKmhWr0snojdcaOm0j6UweHemT0gLt57DuqjupNreSGwVMHhP
	 7yROL7dmPzSE5x55MEWpDvg+XdeM7gj/caaKPdSr6jPfekhRoGadnE5MnyOEqs4+y6
	 VaUz3llWeCuQqdB0WqCcZO82WSzD+4ZTyPFhAvoR+QleoaDBOKKt9UUjCfH5500pKt
	 mgO6APepzwp/A==
Date: Thu, 26 Jun 2025 14:53:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: liu.xuemei1@zte.com.cn, devel@lists.libvirt.org
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, liu.song13@zte.com.cn
Subject: Re: [PATCH] remote/stream-event: Fix a memory leak in??
 remoteStreamCallbackFree()
Message-ID: <20250626195327.GA1634935@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626141038445ZnnRRHX3QpBjC7RGFRlrw@zte.com.cn>

[+to libvirt development list, since this looks like a libvirt patch,
not a Linux kernel patch]

On Thu, Jun 26, 2025 at 02:10:38PM +0800, liu.xuemei1@zte.com.cn wrote:
> From: Liu Song <liu.song13@zte.com.cn>
> 
> The ff callback is never called in remoteStreamCallbackFree() because
> cbdata->cb can not be NULL. This causes a leak of 'cbdata->opaque'.
> 
> The leak can be reproduced by attaching and detaching to the console of
> an VM using `virsh console`.
> 
> ASAN reports the leak stack as:
> Direct leak of 288 byte(s) in 1 object(s) allocated from:
>     #0 0x7f6edf6ba0c7 in calloc (/lib64/libasan.so.8+0xba0c7)
>     #1 0x7f6edf5175b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x615b0)
>     #2 0x7f6ede6d0be3 in g_type_create_instance (/lib64/libgobject-2.0.so.0+0x3cbe3)
>     #3 0x7f6ede6b82cf in g_object_new_internal (/lib64/libgobject-2.0.so.0+0x242cf)
>     #4 0x7f6ede6b9877 in g_object_new_with_properties (/lib64/libgobject-2.0.so.0+0x25877)
>     #5 0x7f6ede6ba620 in g_object_new (/lib64/libgobject-2.0.so.0+0x26620)
>     #6 0x7f6edeb78138 in virObjectNew ../src/util/virobject.c:252
>     #7 0x7f6edeb7a78b in virObjectLockableNew ../src/util/virobject.c:274
>     #8 0x558251e427e1 in virConsoleNew ../tools/virsh-console.c:369
>     #9 0x558251e427e1 in virshRunConsole ../tools/virsh-console.c:427
> 
> Signed-off-by: Liu Song <liu.song13@zte.com.cn>
> ---
>  src/remote/remote_daemon_stream.c | 2 +-
>  src/remote/remote_driver.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/remote/remote_daemon_stream.c b/src/remote/remote_daemon_stream.c
> index 453728a66b..a5032f9a43 100644
> --- a/src/remote/remote_daemon_stream.c
> +++ b/src/remote/remote_daemon_stream.c
> @@ -437,13 +437,13 @@ int daemonAddClientStream(virNetServerClient *client,
>          return -1;
>      }
> 
> +    virObjectRef(client);
>      if (virStreamEventAddCallback(stream->st, 0,
>                                    daemonStreamEvent, client,
>                                    virObjectUnref) < 0)
>          return -1;
> 
>      virObjectRef(client);
> -
>      if ((stream->filterID = virNetServerClientAddFilter(client,
>                                                          daemonStreamFilter,
>                                                          stream)) < 0) {
> diff --git a/src/remote/remote_driver.c b/src/remote/remote_driver.c
> index 2690c05267..9ac13469e9 100644
> --- a/src/remote/remote_driver.c
> +++ b/src/remote/remote_driver.c
> @@ -5336,7 +5336,7 @@ static void remoteStreamCallbackFree(void *opaque)
>  {
>      struct remoteStreamCallbackData *cbdata = opaque;
> 
> -    if (!cbdata->cb && cbdata->ff)
> +    if (cbdata->ff)
>          (cbdata->ff)(cbdata->opaque);
> 
>      virObjectUnref(cbdata->st);
> -- 
> 2.27.0

