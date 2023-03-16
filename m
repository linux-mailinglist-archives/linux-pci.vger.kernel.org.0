Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07846BCE3A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 12:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCPLcI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 07:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCPLbw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 07:31:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96559B861F;
        Thu, 16 Mar 2023 04:31:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CE6F5CE1C98;
        Thu, 16 Mar 2023 11:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D4FC433EF;
        Thu, 16 Mar 2023 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678966293;
        bh=NaAz8BM3yRRJI2dZd/Ku41AygvU2BVnVHs3S3JHtGAc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kUVTsx/BR9ZRIFbVRm2dx+LFxafLeEwwFV3Dti3q+kVDgvjbCnB638J2/+9ttAzaW
         W22qMP6tHp4gDmOcEwNCRv9yyj9ZAFAwrlxCN7lm94cY71wpG9eae7m3eFmE9IGWA0
         2I4DINE3s4lOIx/n7x53TAgbNyq/JCh/khrkPNQINBJ4Oenr8AXLyh+/MJ5Jj1B/vs
         fnayTZgr3iR0zTj9n7QbC1uemBWps5nANdZKWK3h9qTbq4fii16ftJ3YukXsdK6AtB
         F+ajeCzCxuLaLMTAW8i7QSw27LmhmW3jyTpXJUvCpiyxo+9UVVMH4/iAxR/wZneVod
         hDCG5xVYyBh/w==
Message-ID: <7bee3bba-d9e3-18fd-2aff-4316fe097741@kernel.org>
Date:   Thu, 16 Mar 2023 12:31:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v10 1/5] dt-bindings: PCI: ti,j721e-pci-*: add checks for
 num-lanes
Content-Language: en-US
To:     Achal Verma <a-verma1@ti.com>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Milind Parab <mparab@cadence.com>,
        wojciech.jasko-EXT@continental-corporation.com
References: <20230316071238.200992-1-a-verma1@ti.com>
 <20230316071238.200992-2-a-verma1@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230316071238.200992-2-a-verma1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/03/2023 08:12, Achal Verma wrote:
> From: Matt Ranostay <mranostay@ti.com>
> 
> Add num-lanes schema checks based on compatible string on available lanes
> for that platform.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

Since you skipped important  DT list, there will be no checks executed
here. It's a NAK unfortunately. :(

Best regards,
Krzysztof

