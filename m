Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03AD779E31
	for <lists+linux-pci@lfdr.de>; Sat, 12 Aug 2023 10:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjHLIbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Aug 2023 04:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjHLIbU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Aug 2023 04:31:20 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5881F271E;
        Sat, 12 Aug 2023 01:31:24 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id DD35330000CC5;
        Sat, 12 Aug 2023 10:31:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CFB5410177; Sat, 12 Aug 2023 10:31:22 +0200 (CEST)
Date:   Sat, 12 Aug 2023 10:31:22 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <20230812083122.GA26735@wunner.de>
References: <20230810163342.1059509-1-alistair.francis@wdc.com>
 <b3d437f5-fe33-4677-e336-a67ac9b8d477@kernel.org>
 <CAKmqyKOpgTUOzPMhe3Dr1H6BiFZYHrBHFpiESyXitRHbdH0+LA@mail.gmail.com>
 <20230812080509.GA9469@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812080509.GA9469@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 12, 2023 at 10:05:09AM +0200, Lukas Wunner wrote:
> If there are DOE mailboxes, let ->is_visible of the DOE group
> return true and use "doe" as its ->name to make attributes appear

Sorry I meant to say let it return a valid umask (instead of true).

> in a "doe" subdirectory.  Finally allocate and fill a struct
> struct attribute[] array with all the protocols found in all the
> mailboxes.
