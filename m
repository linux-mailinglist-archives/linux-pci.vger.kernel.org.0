Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC38322FC08
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 00:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgG0WVU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 18:21:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:57946 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0WVU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 18:21:20 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A830D44A;
        Mon, 27 Jul 2020 22:21:19 +0000 (UTC)
Date:   Mon, 27 Jul 2020 16:21:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: correct flag name
Message-ID: <20200727162118.32733898@lwn.net>
In-Reply-To: <1595778455-12132-1-git-send-email-Julia.Lawall@inria.fr>
References: <1595778455-12132-1-git-send-email-Julia.Lawall@inria.fr>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 26 Jul 2020 17:47:35 +0200
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> RESOURCE_IO does not exist.  Rename to IORESOURCE_IO.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
> Just a guess based on the most similar name...
> 
>  Documentation/filesystems/sysfs-pci.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/sysfs-pci.rst b/Documentation/filesystems/sysfs-pci.rst
> index a265f3e..742fbd2 100644
> --- a/Documentation/filesystems/sysfs-pci.rst
> +++ b/Documentation/filesystems/sysfs-pci.rst
> @@ -63,7 +63,7 @@ files, each with their own function.
>    binary - file contains binary data
>    cpumask - file contains a cpumask type
>  
> -.. [1] rw for RESOURCE_IO (I/O port) regions only
> +.. [1] rw for IORESOURCE_IO (I/O port) regions only
>  
>  The read only files are informational, writes to them will be ignored, with
>  the exception of the 'rom' file.  Writable files can be used to perform

Applied, thanks.

jon
