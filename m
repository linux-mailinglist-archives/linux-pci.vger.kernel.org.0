Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6908D770596
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 18:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjHDQFx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 12:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjHDQFw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 12:05:52 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF9649D4;
        Fri,  4 Aug 2023 09:05:44 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id E1DCD100D5863;
        Fri,  4 Aug 2023 18:05:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 97DCB6BE62; Fri,  4 Aug 2023 18:05:42 +0200 (CEST)
Date:   Fri, 4 Aug 2023 18:05:42 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        christian.koenig@amd.com, kch@nvidia.com, logang@deltatee.com,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <20230804160542.GA19120@wunner.de>
References: <20230801121824.174556-1-alistair.francis@wdc.com>
 <2023080152-disobey-widen-65a4@gregkh>
 <CAKmqyKMEqrfP8BrXd9pVd4a5Aodipty-8bAkxK5xcGSewsC9JA@mail.gmail.com>
 <20230801170739.000048cb@Huawei.com>
 <CAKmqyKND01=xaiB-VFVsi3+KRbxu4dBKfh_RhCN-jric5VzNpA@mail.gmail.com>
 <20230802225248.GA19409@wunner.de>
 <CAKmqyKNypBUPNK37wby-0_7G2-10BmZ4f8WQbevVn9uX1mZreQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKNypBUPNK37wby-0_7G2-10BmZ4f8WQbevVn9uX1mZreQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 04, 2023 at 11:17:59AM -0400, Alistair Francis wrote:
> On Wed, Aug 2, 2023 at 6:52???PM Lukas Wunner <lukas@wunner.de> wrote:
> > I kind of like the approach of exposing a list which can be grep'ed,
> > even though it may go against the rule of having just one datum per
> > attribute.  I'd prefer a representation that's human-readable though,
> > e.g. "0001:01" for CMA-SPDM.
> 
> Yeah, it's my preferred method as well, but it's not going to be
> accepted upstream

How about procfs instead of sysfs?

No "single datum per file" rule over there.
PCI content goes into /proc/bus/pci/.
Already used by lspci to access config space.

Thanks,

Lukas
