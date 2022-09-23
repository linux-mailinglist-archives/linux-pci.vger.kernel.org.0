Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C160D5E82E9
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 22:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiIWULN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 16:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIWULM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 16:11:12 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7619011DFCA;
        Fri, 23 Sep 2022 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=UKGkJSDEegt6Km6YnASFgTL/rZgzcY69GV8aEjSrBsw=; b=Uk3BJ2VHv+0S4jWHSA/rtq3PWC
        Zj9PsoIM/Z7XnRTaL5ne1xXzusxv8rr55DkC1OmoHUwIWkaZ+Jpepoglgn0v3hyI2SvBzpQQPB7/I
        pOzSUqMPA2jHYvbYN7r7oL1saGjNZNZxZZl/Qa9MxLkY2XbnIcupaFB9+/ymV/qcrL0ambaJlozZA
        iz9rqIPUWbtwxVNqkUFYgqxw8Tw3cB3ChEfoRI9T2u9bJwQnnupTD5u0NfCsylJQb8zJCg5sMGt3b
        O2XS16tx23f40e3Qwgn5Q7E+PItgegCw2qWKbMcuoZvBT0Rtwht0AGeyszOrU2alxd7kuxnWVCgDG
        7MWeKj5w==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1obp0t-008yJz-3Q; Fri, 23 Sep 2022 14:11:09 -0600
Message-ID: <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
Date:   Fri, 23 Sep 2022 14:11:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-2-logang@deltatee.com> <Yy33LUqvDLSOqoKa@ziepe.ca>
 <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
 <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v10 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting PCI
 P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-09-23 13:53, Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 01:08:31PM -0600, Logan Gunthorpe wrote:
> I'm encouraging Dan to work on better infrastructure in pgmap core
> because every pgmap implementation has this issue currently.
> 
> For that reason it is probably not so relavent to this series.
> 
> Perhaps just clarify in the commit message that the FOLL_LONGTERM
> restriction is to copy DAX until the pgmap page refcounts are fixed.

Ok, I'll add that note.

Per the fix for the try_grab_page(), to me it doesn't fit well in 
try_grab_page() without doing a bunch of cleanup to change the
error handling, and the same would have to be added to try_grab_folio().
So I think it's better to leave it where it was, but move it below the 
respective grab calls. Does the incremental patch below look correct?

I am confused about what happens if neither FOLL_PIN or FOLL_GET 
are set (which the documentation for try_grab_x() says is possible, but
other documentation suggests that FOLL_GET is automatically set). 
In which case it'd be impossible to do the check if we can't 
access the page.

I'm assuming that seeing there are other accesses to the page in these
two instances of try_grab_x() that these spots will always have FOLL_GET
or  FOLL_PIN set and thus this isn't an issue. Another reason not
to push the check into try_grab_x().

Logan

--

diff --git a/mm/gup.c b/mm/gup.c
index 108848b67f6f..f05ba3e8e29a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -601,12 +601,6 @@ static struct page *follow_page_pte(struct vm_area_struct >
                goto out;
        }
 
-       if (unlikely(!(flags & FOLL_PCI_P2PDMA) &&
-                    is_pci_p2pdma_page(page))) {
-               page = ERR_PTR(-EREMOTEIO);
-               goto out;
-       }
-
        VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
                       !PageAnonExclusive(page), page);
 
@@ -615,6 +609,13 @@ static struct page *follow_page_pte(struct vm_area_struct >
                page = ERR_PTR(-ENOMEM);
                goto out;
        }
+
+       if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page))) {
+               gup_put_folio(page_folio(page), 1, flags);
+               page = ERR_PTR(-EREMOTEIO);
+               goto out;
+       }
+
        /*
         * We need to make the page accessible if and only if we are going
         * to access its content (the FOLL_PIN case).  Please see
@@ -2392,14 +2393,16 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr,>
                VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
                page = pte_page(pte);
 
-               if (unlikely(!(flags & FOLL_PCI_P2PDMA) &&
-                            is_pci_p2pdma_page(page)))
-                       goto pte_unmap;
-
                folio = try_grab_folio(page, 1, flags);
                if (!folio)
                        goto pte_unmap;
 
+               if (unlikely(!(flags & FOLL_PCI_P2PDMA) &&
+                            is_pci_p2pdma_page(page))) {
+                       gup_put_folio(folio, 1, flags);
+                       goto pte_unmap;
+               }
+
                if (unlikely(page_is_secretmem(page))) {
                        gup_put_folio(folio, 1, flags);
                        goto pte_unmap;
