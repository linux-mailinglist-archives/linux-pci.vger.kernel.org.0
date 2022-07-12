Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567CD5726D3
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiGLT6B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 15:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiGLT57 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 15:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B30E59;
        Tue, 12 Jul 2022 12:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D35D619E9;
        Tue, 12 Jul 2022 19:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C12EC3411E;
        Tue, 12 Jul 2022 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657655876;
        bh=YJoRqyJy3qiIn78UeNVjkHQRPeIz+c/iaaoaMAVpK84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P3y8BQAYziE60EfNr9XOgE8zBOjSpqtOu2EhXuMdNyH6GC313kO7bhBPRXqbQkU+V
         ufF9T4/lDqGnCrfSpA2+ym/U+mP+a/i1rcFLlcQteJ8C/No8l+XucO+mmw3mxP8n27
         vDEfcd3cUobtGND5kXpbkzXUItXEcmAatZatTvUcWpTZt4BjyOt9BPSKSR82wcfrPQ
         YMPHNrE1piiYTICazESrv3EavycvvF2CauIW02blun7Y3oPLo7cBSMkofPip0BRips
         PO+KBj1ei3MGXhF08kUblyy6bhsE0YNQx9P1DC6IEJHyoel/k2kqXczFzRqfVtCFN5
         lX8zmmiEKm/lw==
Date:   Tue, 12 Jul 2022 14:57:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 04/12] docs: PCI: pci-vntb-function.rst: Properly include
 ascii artwork
Message-ID: <20220712195754.GA790963@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eeaa329cc4fa64829ff0bdaf8f10e68f7283ac7.1656759989.git.mchehab@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jon, Frank]

On Sat, Jul 02, 2022 at 12:07:36PM +0100, Mauro Carvalho Chehab wrote:
> Adjust identation and add a "::" in order to properly mark the
> ascii artwork as a code block, fixing this warning:
> 
> 	Documentation/PCI/endpoint/pci-vntb-function.rst:82: WARNING: Unexpected indentation.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

The series that adds this doc appears to be being merged via Jon
(cc'd).

> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/
> 
>  Documentation/PCI/endpoint/pci-vntb-function.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/PCI/endpoint/pci-vntb-function.rst b/Documentation/PCI/endpoint/pci-vntb-function.rst
> index cad8013e8839..7b2ac70e2c57 100644
> --- a/Documentation/PCI/endpoint/pci-vntb-function.rst
> +++ b/Documentation/PCI/endpoint/pci-vntb-function.rst
> @@ -58,7 +58,7 @@ It is same as PCI NTB Function driver
>  Scratchpad Registers:
>  ---------------------
>  
> -  It is appended after Config region.
> +It is appended after Config region::
>  
>    +--------------------------------------------------+ Base
>    |                                                  |
> -- 
> 2.36.1
> 
