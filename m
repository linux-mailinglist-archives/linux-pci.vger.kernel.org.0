Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1EF5726D9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 21:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiGLT6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 15:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiGLT6g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 15:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A032BE9;
        Tue, 12 Jul 2022 12:58:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01FD861764;
        Tue, 12 Jul 2022 19:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2778AC3411E;
        Tue, 12 Jul 2022 19:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657655912;
        bh=hCy5lLxfGKLFkUwDOvKrekJ8LJ+EmLaIlit4nCjzajQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dn+sv7liPJQ4Pjj71MPVG9akwaxaGkGlrEt6ELc/5qVpNz8Zi1DMP1Q6YHwQKuv6i
         0CWw4XAbZ3jJaemHxESaolPULXlv1+rUSjGW7Pfm05zdQN5lMJnwAgTfRmLL+8s1/a
         hxijc/eSpsocaHtO9IlJ0Pi1N8OKOjnQaDvU5OgDb2BTDr0P1qf/wMxkwG1wk7boQV
         ibHI864MvxvErSIibR/SjJeKraBSvn8rQQet2NvnX4EtrPdHVxW3BwGnCnlh6xSaQf
         SO4zOpfOaq/oZLLduRg+ioy/RlfrfckYWk1amAU0T6xGL2yEnea+T1ljYXNxg2kOev
         UVzof9xCHJ9eA==
Date:   Tue, 12 Jul 2022 14:58:30 -0500
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
Subject: Re: [PATCH 05/12] docs: PCI: pci-vntb-howto.rst: fix a title markup
Message-ID: <20220712195830.GA791058@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ae1b19414346e6b07d57dbaf68a2b4cb273ccb.1656759989.git.mchehab@kernel.org>
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

On Sat, Jul 02, 2022 at 12:07:37PM +0100, Mauro Carvalho Chehab wrote:
> As warned by Sphinx:
> 	Documentation/PCI/endpoint/pci-vntb-howto.rst:131: WARNING: Title underline too short.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Another for Jon.

> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/
> 
>  Documentation/PCI/endpoint/pci-vntb-howto.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
> index b4a679144692..31a0bae868f9 100644
> --- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
> +++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
> @@ -128,7 +128,7 @@ RootComplex Device
>  ==================
>  
>  lspci Output at Host side
> -------------------------
> +-------------------------
>  
>  Note that the devices listed here correspond to the values populated in
>  "Creating pci-epf-ntb Device" section above::
> -- 
> 2.36.1
> 
