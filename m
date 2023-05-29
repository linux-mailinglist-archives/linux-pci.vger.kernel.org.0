Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C11714D52
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 17:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjE2Pq4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 11:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjE2Pq4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 11:46:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1BCA3
        for <linux-pci@vger.kernel.org>; Mon, 29 May 2023 08:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE58F62679
        for <linux-pci@vger.kernel.org>; Mon, 29 May 2023 15:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09870C433D2;
        Mon, 29 May 2023 15:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685375214;
        bh=mKRrO3Wz/YyEX8plb/G4WmYfW69ahJrEcJGGNa6e8nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZM+HgPSZayjvCB6X3WYX2roS6hcbj/1L3ldF2YWjLMERNdAIrvXy5gPcYNYFY9HY
         /KUXenRluBaoc2/HDpYP3XAHJSzZF76mxkV4T/0T7Yd+ANNgNwsbojTH5nagpWnjZP
         w5Z2PPEfWyBuVZzJigWo0ZkstFpT9iEeUWEuXBNV9CmDs7PUNEfj+M1iaTszNCqp8x
         PUmjjBhR9UbV059qPLhD8HQolnW8ugBlijUXtJV1fY89FDPcygzrjjcG7EPW/jYzIi
         /GwF7qwui6AP9DlaZsNk0oi3xMt7vpRERy8ozSmYvz6iC+n/1HTBClHHe4bwc4kDh6
         9cPtXs3xXbRJw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v2 0/2] Fixup changes to pci_epf_type_add_cfs()
Date:   Mon, 29 May 2023 17:46:48 +0200
Message-Id: <168537514320.39697.6650169753687543200.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515074348.595704-1-dlemoal@kernel.org>
References: <20230515074348.595704-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 15 May 2023 16:43:46 +0900, Damien Le Moal wrote:
> A couple of patches to improve and document the changes to
> pci_epf_type_add_cfs() done with patch
> 893f14fed7d3 ("PCI: endpoint: Move pci_epf_type_add_cfs() code").
> 
> Changes from v1:
>  - Changed error from EINVAL to ENODEV in patch 1
>  - Removed spurious line in kdoc comment in patch 2
> 
> [...]

Squashed second patch with the patch it was fixing and 
applied [1/2] to controller/endpoint, thanks!

[1/2] PCI: endpoint: Improve pci_epf_type_add_cfs()
      https://git.kernel.org/pci/pci/c/de22e068e9bb
	    //
Thanks,
Lorenzo
