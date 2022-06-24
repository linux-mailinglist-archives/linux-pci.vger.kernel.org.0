Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6904F55984C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 13:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiFXLIm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 24 Jun 2022 07:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiFXLIm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 07:08:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA3954FB2;
        Fri, 24 Jun 2022 04:08:38 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LTvQc4Wfnz67bcp;
        Fri, 24 Jun 2022 19:04:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 13:08:35 +0200
Received: from localhost (10.81.207.131) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 24 Jun
 2022 12:08:34 +0100
Date:   Fri, 24 Jun 2022 12:08:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Ira Weiny <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "ben@bwidawsk.net" <ben@bwidawsk.net>, <linuxarm@huawei.com>,
        <lorenzo.pieralisi@arm.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re: (SPDM) Device attestation, secure channels from host to device
 etc: Discuss at Plumbers?
Message-ID: <20220624120830.00002eef@Huawei.com>
In-Reply-To: <20220622124638.00004456@Huawei.com>
References: <20220609124702.000037b0@Huawei.com>
        <YqICCSd/6Vxidu+v@iweiny-desk3>
        <20220617112124.00002296@Huawei.com>
        <20220620165217.GA18451@wunner.de>
        <20220622124638.00004456@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.81.207.131]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 22 Jun 2022 12:46:38 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 20 Jun 2022 18:52:17 +0200
> Lukas Wunner <lukas@wunner.de> wrote:
> 
> > On Fri, Jun 17, 2022 at 11:21:24AM +0100, Jonathan Cameron wrote:  
> > > On Thu, 9 Jun 2022 07:22:01 -0700 Ira Weiny <ira.weiny@intel.com> wrote:    
> > > > On Thu, Jun 09, 2022 at 12:47:02PM +0100, Jonathan Cameron wrote:    
> > > > > I'll start by saying I haven't moved forward much with the
> > > > > SPDM/CMA over Data Object Exchange proposal from the PoC that led to
> > > > > presenting it last year as part of the PCI etc uconf last year.
> > > > > https://lpc.events/event/11/contributions/1089/
> > > > > https://lore.kernel.org/all/20220303135905.10420-1-Jonathan.Cameron@huawei.com/
> > > > > I'm continuing to carry the QEMU emulation but not posted for a while
> > > > > as we are slowly working through a backlog of CXL stuff to merge.    
> > 
> > So the SDPM series you posted in March is the latest version?  
> 
> Hi Lukas,
> 
> Yes and the March version is (more or less) a rebase of the proposal
> used to drive the conversation at Plumbers PCI uconf last year.
> I have some prototype measurement code but probably not a lot of
> point in doing anything with that until the basic stuff is in place.
> 
> > 
> > If you lack bandwidth to carry on with it, I would pick up the baton
> > and rework that version based on the review feedback I've posted.
> > (Unless someone else is eager to do that.)  
> 
> I'm always keen to leverage offers of help - I want the end result
> and am more than happy if someone else drives it forwards. There is
> plenty to keep lots of people busy in this space.
> 
> It wasn't so much bandwidth that was restricting my work on this, but
> more precursors and open questions. Also 
> 
> * DOE is undergoing another rewrite after recent review of v11 from Dan.
> * At the moment the in kernel solution is 'competing' with a proposal
>   to do stuff in userspace that is currently words only and tied up
>   with the somewhat similar stuff for TLS sessions setup.
>   I see there is continuing work on inband NVME authentication posted.
> 
> Personally I diverted into putting as second transport in place so that
> we are sure that layering is correct (MCTP) - however the way MCTP is
> handled by the kernel is not that friendly to in kernel use - it might
> be doable but there is a userspace part in that path (to configure the
> mctp routing etc).
> 
> From point of view of the RFC, if you want to take that forwards that
> would be fine by me.  Beyond responding to review feedback there are
> some missing features we would need.
> 
> 1) Slot handling - right now it only uses the first slot.
> 2) SPDM 1.2 support (maybe just move 1.2)
> 3) Actually doing something useful beyond basic attestation.
> 
> For those, perhaps just shout if you are taking one on so that we don't
> duplicate and I'll do the same if I get to one of them.
> 
> I have a side project to get SPDM over MCTP running as well to see
> what that story looks like.  We may want to share infrastructure, but
> it won't typically run on the same system so there is probably no
> requirement to do so.
> 
> > 
> >   
> > > > Yes, while this could work as part of the CXL uconf it is probably a more
> > > > general topic.    
> > > 
> > > Maybe steal time from PCI given CXL uconf is going to be busy!
> > > (lets see if any of the PCI folk are reading this thread.. :)
> > > 
> > > At the moment I'm not seeing enough interest to put in a proposal for
> > > anything 'officially scheduled', but there is a bit more time until
> > > the deadline so let's see if we get any other interest in that time.    
> > 
> > How about a BoF session to discuss the status quo and any open issues?  
> 
> Ok. I'm not yet clear we have critical mass but I'll put an application
> in the system. Can always pull it before the deadline if it looks like
> we don't have enough interest to take up a slot.  We can schedule
> something at another time if it doesn't work out, but Plumbers hopefully
> has a critical mass of right people present to make rapid progress if
> we can get some people in a room (with others online).

I've put this in for now:

"
Device attestation, secure channel setup / SPDM - how to make progress?

In 2021, at the Plumbers VFIO/IOMMU/PCI micro-conference, we introduced
device attestation of PCI devices via Component Measurement and
Authentication (CMA) / Security Protocol and Data Model (DMTF - SPDM). 
https://lpc.events/event/11/contributions/1089/ However, device
attestation and SPDM is not a PCI specific topic and the decisions made
for a Linux implementation need to take into account other transports 
and use cases. Hence this proposal for a BoF rather than session in 
either PCI or CXL uconf. Whilst the 2021 session was productive in 
raising awareness of this important topic and finding others who had 
short term requirements, it was new to many of those attending so 
little progress was made on some of the open questions.

Moving forwards a year, interest in this space has grown with the 
side effect that the list of questions is getting ever longer and 
fundamental disagreements have occurred that would benefit from 
face to face discussion. As such, this BoF will assume the audience 
are at least somewhat familiar with the topic and what has been 
proposed and move rapidly onto plotting a path forwards.

Current status
- RFC for in kernel session establishment. March 2022
https://lore.kernel.org/all/20220303135905.10420-1-Jonathan.Cameron@huawei.com/
- Discussion threads:
https://lore.kernel.org/all/CAPcyv4jb7D5AKZsxGE5X0jon5suob5feggotdCZWrO_XNaer3A@mail.gmail.com/
https://lore.kernel.org/all/20220511191345.GA26623@wunner.de/
https://lore.kernel.org/all/CAPcyv4iWGb7baQSsjjLJFuT1E11X8cHYdZoGXsNd+B9GHtsxLw@mail.gmail.com/

Major Proposed Topics:
- Use models / transports. Need to enumerate these to understand if 
  one solution or several needed.
- Secure channel negotiation in kernel or in user-space (or novel
  solutions). The recent discussions of TLS negotiation are somewhat 
  related, though the necessary flows in SPDM are highly constrained 
  and always host initiated, perhaps leading to a different decision. 
  (TLS coverage on LWN https://lwn.net/Articles/896746/) There is not
  a suitable user-space library / daemon today (discuss adaptation
  of DMTF reference implementation)
- Certificate management. Current proposal is simple but is it fine
  grained enough?
- Policy control. What is fall back if we can’t attest the device? 
  Device driver specific, or more general?
- Emulation requirements before commonly available hardware. QEMU 
  support for the PCI/CMA transport is available, QEMU emulation 
  MCTP over I2C PoC planned.

People likely to be interested:
- Security / attestation specialists
- Those involved in the TLS work who may be able to advise on how to 
  avoid pitfalls they have met.
- PCI driver developers (for attestation and also Link Encryption key 
  exchange)
- CXL developers (attestation and Link Encryption)
- USB? Others. SPDM is used on these transports, but not clear if OS 
  level support needed.
- Anyone who likes reading specifications.
"

I can edit this for a few more weeks - so all comments welcome!

Please express interest in attending / helping to drive this discussion
as we'll need critical mass to make good progress.

Thanks,

Jonathan


> 
> 
> > 
> > (I'm not involved with CXL, hence probably belong to "PCI folk".)  
> 
> :)
> 
> > 
> >   
> > > > I [...] was hoping to go in person but I'm unsure of travel budgets.
> > > > I will likely be virtual if I can't attend in person.    
> > 
> > Same.  
> 
> Hopefully see you there, space and travel budgets willing.
> 
> Jonathan
> 

