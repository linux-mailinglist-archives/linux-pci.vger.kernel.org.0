Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5468C5BB
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 19:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBFS2r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 13:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBFS2r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 13:28:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE3A23DA0;
        Mon,  6 Feb 2023 10:28:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 030C8B815B1;
        Mon,  6 Feb 2023 18:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CB4C433D2;
        Mon,  6 Feb 2023 18:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675708123;
        bh=JxuvSWe0qvj0fZ0Qi87c07Fgy6GEu4WU/4Tvj8Mjh2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubwGoROz/rT6baByWtwjMS5j9w3hB58/8j7ZX0Srwuah7VepijVzzC8LYQs3T8/Eu
         sM4XAuBEQPpAqPpD7VpzCdEazcW6gim1kw4M8nm1UjVUxNyvfyOWvB21hCDf6FFJeD
         0MznoSwX2v0/uZcN4uYtyBlXaugpZj9ABL9i/HWxYNqIK7peQ/6Q1LjNuDYo0Nempa
         GSAeHoSGtGOTgDurJwd3U0hMYAnqSJV1hWPbjY0ZSM3hHD7rjDLjLM6aDqh5Lwsj7F
         IVeK1b0fhLxotKgcfkyRETSOmeABaNNSrpr5P+MPffci1667WhDM7wQRSst7LTAZHz
         GZ7kvGCgA/slw==
Date:   Mon, 6 Feb 2023 11:28:40 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     Xinghui Li <korantwork@gmail.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0
 controller
Message-ID: <Y+FG2EUpmsmCZqwh@kbusch-mbp.dhcp.thefacebook.com>
References: <20221222072603.1175248-1-korantwork@gmail.com>
 <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev>
 <Y6TSgGdCTvkwPiVg@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com>
 <d14ac29d-027a-08a7-c5c8-848a6920d4a2@linux.dev>
 <CAEm4hYXncuvL-Gk1aEZExrvkbx=N1aiOQNeNjFdB4443EbKNBA@mail.gmail.com>
 <f05ee82a-4532-b12b-490f-904b946ff7b0@linux.dev>
 <CAEm4hYXk1RuKEw41VukH2iGTo_9GmZjUfrESWK5vFtpFA_O_4A@mail.gmail.com>
 <CAEm4hYWeZFrYxSvAcBJ8iw=t507vZMqfBwiQXFSJd2Hcyfw7fA@mail.gmail.com>
 <9e6cfda1-4309-d1bb-a0cf-404a7fe7d3aa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e6cfda1-4309-d1bb-a0cf-404a7fe7d3aa@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 11:11:36AM -0700, Patel, Nirmal wrote:
> I like the idea of module parameter to allow switching between the modes
> but keep MSI remapping enabled (non-bypass) by default.

Isn't there a more programatic way to go about selecting the best option at
runtime? I suspect bypass is the better choice if "num_active_cpus() > pci_msix_vec_count(vmd->dev)".
