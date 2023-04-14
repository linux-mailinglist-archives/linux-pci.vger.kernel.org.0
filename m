Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FAC6E281D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDNQMl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 12:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjDNQMh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 12:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1623F5FF6
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 09:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A34DF64773
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 16:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CABC433EF;
        Fri, 14 Apr 2023 16:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681488755;
        bh=RBBlAOCc+NTxu3Lfz6QWtmLVziblFTrp4hmfEiZXnF4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nRr2ToSQe9+Oc9rZUo6qklWSWGRp4D0EWLlV/8MtjKDf8Mz8y8WtETMVSodhRiOHU
         +4X1218FFGo73ZBeI68jh03vXPFbTizCgL0NXRszTWivyXiEbhfUu5foMrmgNHH+zF
         VmD7OE85Wtxq2EEvvcf73JjWPz2zbhQGMwgCEloBF8NCqkvLJB6bY9vPOdTPp2pJIe
         ZgmHe6JjhP81GVMOL5/s3m1rV78yzglbN2oIXRNhtFUkNTn3cC7cU8p7OuKYZ5gBkG
         erVovf+u+qpf+2RDCX3YIwLCbWz8+14p7Vj1oXUGIeK/8uJr4dsrA/22/8wktJi2IL
         pjRm6XYALVkRw==
Date:   Fri, 14 Apr 2023 11:12:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 10/17] PCI: epf-test: Cleanup
 pci_epf_test_cmd_handler()
Message-ID: <20230414161233.GA198090@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330085357.2653599-11-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:50PM +0900, Damien Le Moal wrote:
> Command codes are never combined together as flags into a single value.
> Thus we can replace the series of "if" tests in
> pci_epf_test_cmd_handler() with a cleaner switch-case statement.
> This also allows checking that we got a valid command and print an error
> message if we did not.

> +	default:
> +		dev_err(dev, "Invalid command\n");

Include the invalid command value here for debugging.

> +		break;
>  	}
>  
>  reset_handler:
> -- 
> 2.39.2
> 
