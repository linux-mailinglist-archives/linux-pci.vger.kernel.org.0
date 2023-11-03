Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173207DFD8B
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 01:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjKCATK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 20:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjKCATK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 20:19:10 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A17136;
        Thu,  2 Nov 2023 17:19:06 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7b6043d0b82so650851241.1;
        Thu, 02 Nov 2023 17:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698970746; x=1699575546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOhw4xGC/n9d+rmUSV7UwmijbxlMewNzQkkMPoyO4D4=;
        b=mgAgryM72wWIYWqd8eXvqjeQYYIUsV9htIX2h2YOfSgv6xRmGT407KB9I+UJfBUjNY
         U4ipaUzt1a9RPM0kBazBd2h5op+nr2qADnEVf6j2X/B6Gemtgb0vKqNUtjJgeK6NGnai
         BwxLC7PRl440SyuHt/EN9yIc7EN75CJW7y6UT9sPAHI+rwIDFnmH944cHhdTK247YU9g
         IaUalWXlneQya3zjxphCzE1ah37/15O41lMsWEqkGFEiTMigtWvwoc8i13NRuj2TUmAu
         IQfOV+pFHqKirpH9x6uFjG0uHm0gC1XkVrEhg+864qcOJxpPEc2h6tHNOr50tiLNzCT0
         rdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698970746; x=1699575546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOhw4xGC/n9d+rmUSV7UwmijbxlMewNzQkkMPoyO4D4=;
        b=DkhPcFs+J9rsQo8sWQh7/09aXOphpUQmHJFbDkFMTfr3w5/JQULlBuad8FUaRqfFDE
         bUPaf9+lsN9wJxEHgD31nn8on8sKgEDuGRzN+bLbCfgUqpwm1z4hd8WHRmhkm+hY8xca
         BxogpW+mvDMh9AJibPmqocwFrjhNGDpF+ILMNifQ4YZXPGIXqLRzwqueEV3jmbCegDJa
         mBLOFKWiMr4zZMNfu8RbFVEVsJWpcLqKzKhTMEDPyxEBJe6GrvoXT/8/3GgPj86TzGU/
         R40VZSlxh2mfxQ7FtmZpYYVM7xpq6EQlLiboIjZq9xF244yf4fCxROF2MKjm4BUdv8RC
         txjA==
X-Gm-Message-State: AOJu0YxOiESY/7VsRtDn5eKcT2kl0cjDxvd4cBuupxNpnEbRai2IaW4s
        b9pYbcNcvhduyPbdtbG72WnCu4i00iqnRKop0u4=
X-Google-Smtp-Source: AGHT+IE3tEaHNEZoDSUuZDyuoyGcbg/4jc7CTzWEXdEAtkwWfSCFXDm0QrJuiLDwhwoDnkPGFtW1YNpgTvuLRLoAjsU=
X-Received: by 2002:a05:6102:2842:b0:45d:704e:a79c with SMTP id
 az2-20020a056102284200b0045d704ea79cmr3226688vsb.21.1698970745531; Thu, 02
 Nov 2023 17:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231013034158.2745127-1-alistair.francis@wdc.com> <20231018222407.GA1380906@bhelgaas>
In-Reply-To: <20231018222407.GA1380906@bhelgaas>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 3 Nov 2023 10:18:38 +1000
Message-ID: <CAKmqyKN5f_Jk6YS2ygy2Tr-r2TBvtnU7XpzeSH4X3XrQHKWtCw@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] PCI/DOE: Rename DOE protocol to feature
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 19, 2023 at 8:24=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Oct 13, 2023 at 01:41:56PM +1000, Alistair Francis wrote:
> > DOE r1.1 replaced all occurrences of "protocol" with the term "feature"
> > or "Data Object Type".
> >
> > PCIe r6.1 (which was published July 24) incorporated that change.
> >
> > Rename the existing terms protocol with feature. This patch
> > also clears up some confusion of type vs protocol/feature, where
> > previously feature would cover the vid and type pair.
>
> Would you mind splitting this up?  It sounds like:
>
>   - A purely textual change from "protocol" to "feature", and
>
>   - Clearing up some confusion about a vendor ID and a type?

These are both just renaming.

 - protocol -> feature
 - prot -> type

The newest PCIe spec doesn't use protocol any more, instead they use
feature and Data Object Type. So this patch is just renaming things to
match.

I have split the patch up into two rename operations in the next version

Alistair

>
> I don't want to have sort through the cosmetic changes to find the
> confusion fix, which sounds like it should have a closer look.
>
> The words "this patch also" in a commit log is always a hint that
> there are two separate things going on that might not need to be in
> the same patch.
>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > ---
> > v9:
> >  - Rename two more DOE macros
> > v8:
> >  - Rename prot to feat as well
> > v7:
> >  - Initial patch
> >
> >
> >  drivers/pci/doe.c             | 94 +++++++++++++++++------------------
> >  include/uapi/linux/pci_regs.h |  2 +-
> >  2 files changed, 48 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index e3aab5edaf70..db2a86edf2e1 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -22,7 +22,7 @@
> >
> >  #include "pci.h"
> >
> > -#define PCI_DOE_PROTOCOL_DISCOVERY 0
> > +#define PCI_DOE_FEATURE_DISCOVERY 0
> >
> >  /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
> >  #define PCI_DOE_TIMEOUT HZ
> > @@ -43,7 +43,7 @@
> >   *
> >   * @pdev: PCI device this mailbox belongs to
> >   * @cap_offset: Capability offset
> > - * @prots: Array of protocols supported (encoded as long values)
> > + * @feats: Array of features supported (encoded as long values)
> >   * @wq: Wait queue for work item
> >   * @work_queue: Queue of pci_doe_work items
> >   * @flags: Bit array of PCI_DOE_FLAG_* flags
> > @@ -51,14 +51,14 @@
> >  struct pci_doe_mb {
> >       struct pci_dev *pdev;
> >       u16 cap_offset;
> > -     struct xarray prots;
> > +     struct xarray feats;
> >
> >       wait_queue_head_t wq;
> >       struct workqueue_struct *work_queue;
> >       unsigned long flags;
> >  };
> >
> > -struct pci_doe_protocol {
> > +struct pci_doe_feature {
> >       u16 vid;
> >       u8 type;
> >  };
> > @@ -66,7 +66,7 @@ struct pci_doe_protocol {
> >  /**
> >   * struct pci_doe_task - represents a single query/response
> >   *
> > - * @prot: DOE Protocol
> > + * @feat: DOE Feature
> >   * @request_pl: The request payload
> >   * @request_pl_sz: Size of the request payload (bytes)
> >   * @response_pl: The response payload
> > @@ -78,7 +78,7 @@ struct pci_doe_protocol {
> >   * @doe_mb: Used internally by the mailbox
> >   */
> >  struct pci_doe_task {
> > -     struct pci_doe_protocol prot;
> > +     struct pci_doe_feature feat;
> >       const __le32 *request_pl;
> >       size_t request_pl_sz;
> >       __le32 *response_pl;
> > @@ -171,8 +171,8 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_=
mb,
> >               length =3D 0;
> >
> >       /* Write DOE Header */
> > -     val =3D FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->prot.v=
id) |
> > -             FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.=
type);
> > +     val =3D FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->feat.v=
id) |
> > +             FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->feat.=
type);
> >       pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
> >       pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> >                              FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LE=
NGTH,
> > @@ -217,12 +217,12 @@ static int pci_doe_recv_resp(struct pci_doe_mb *d=
oe_mb, struct pci_doe_task *tas
> >       int i =3D 0;
> >       u32 val;
> >
> > -     /* Read the first dword to get the protocol */
> > +     /* Read the first dword to get the feature */
> >       pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> > -     if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) !=3D task->=
prot.vid) ||
> > -         (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) !=3D task-=
>prot.type)) {
> > -             dev_err_ratelimited(&pdev->dev, "[%x] expected [VID, Prot=
ocol] =3D [%04x, %02x], got [%04x, %02x]\n",
> > -                                 doe_mb->cap_offset, task->prot.vid, t=
ask->prot.type,
> > +     if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) !=3D task->=
feat.vid) ||
> > +         (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) !=3D task-=
>feat.type)) {
> > +             dev_err_ratelimited(&pdev->dev, "[%x] expected [VID, Feat=
ure] =3D [%04x, %02x], got [%04x, %02x]\n",
> > +                                 doe_mb->cap_offset, task->feat.vid, t=
ask->feat.type,
> >                                   FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_=
1_VID, val),
> >                                   FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_=
1_TYPE, val));
> >               return -EIO;
> > @@ -384,7 +384,7 @@ static void pci_doe_task_complete(struct pci_doe_ta=
sk *task)
> >  }
> >
> >  static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16=
 *vid,
> > -                          u8 *protocol)
> > +                          u8 *feature)
> >  {
> >       u32 request_pl =3D FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDE=
X,
> >                                   *index);
> > @@ -393,7 +393,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe=
_mb, u8 *index, u16 *vid,
> >       u32 response_pl;
> >       int rc;
> >
> > -     rc =3D pci_doe(doe_mb, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_PROTOCOL_DI=
SCOVERY,
> > +     rc =3D pci_doe(doe_mb, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_FEATURE_DIS=
COVERY,
> >                    &request_pl_le, sizeof(request_pl_le),
> >                    &response_pl_le, sizeof(response_pl_le));
> >       if (rc < 0)
> > @@ -404,7 +404,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe=
_mb, u8 *index, u16 *vid,
> >
> >       response_pl =3D le32_to_cpu(response_pl_le);
> >       *vid =3D FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_p=
l);
> > -     *protocol =3D FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
> > +     *feature =3D FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE,
> >                             response_pl);
> >       *index =3D FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
> >                          response_pl);
> > @@ -412,12 +412,12 @@ static int pci_doe_discovery(struct pci_doe_mb *d=
oe_mb, u8 *index, u16 *vid,
> >       return 0;
> >  }
> >
> > -static void *pci_doe_xa_prot_entry(u16 vid, u8 prot)
> > +static void *pci_doe_xa_feat_entry(u16 vid, u8 type)
> >  {
> > -     return xa_mk_value((vid << 8) | prot);
> > +     return xa_mk_value((vid << 8) | type);
> >  }
> >
> > -static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
> > +static int pci_doe_cache_features(struct pci_doe_mb *doe_mb)
> >  {
> >       u8 index =3D 0;
> >       u8 xa_idx =3D 0;
> > @@ -425,18 +425,18 @@ static int pci_doe_cache_protocols(struct pci_doe=
_mb *doe_mb)
> >       do {
> >               int rc;
> >               u16 vid;
> > -             u8 prot;
> > +             u8 type;
> >
> > -             rc =3D pci_doe_discovery(doe_mb, &index, &vid, &prot);
> > +             rc =3D pci_doe_discovery(doe_mb, &index, &vid, &type);
> >               if (rc)
> >                       return rc;
> >
> >               pci_dbg(doe_mb->pdev,
> > -                     "[%x] Found protocol %d vid: %x prot: %x\n",
> > -                     doe_mb->cap_offset, xa_idx, vid, prot);
> > +                     "[%x] Found feature %d vid: %x type: %x\n",
> > +                     doe_mb->cap_offset, xa_idx, vid, type);
> >
> > -             rc =3D xa_insert(&doe_mb->prots, xa_idx++,
> > -                            pci_doe_xa_prot_entry(vid, prot), GFP_KERN=
EL);
> > +             rc =3D xa_insert(&doe_mb->feats, xa_idx++,
> > +                            pci_doe_xa_feat_entry(vid, type), GFP_KERN=
EL);
> >               if (rc)
> >                       return rc;
> >       } while (index);
> > @@ -460,7 +460,7 @@ static void pci_doe_cancel_tasks(struct pci_doe_mb =
*doe_mb)
> >   * @pdev: PCI device to create the DOE mailbox for
> >   * @cap_offset: Offset of the DOE mailbox
> >   *
> > - * Create a single mailbox object to manage the mailbox protocol at th=
e
> > + * Create a single mailbox object to manage the mailbox feature at the
> >   * cap_offset specified.
> >   *
> >   * RETURNS: created mailbox object on success
> > @@ -479,7 +479,7 @@ static struct pci_doe_mb *pci_doe_create_mb(struct =
pci_dev *pdev,
> >       doe_mb->pdev =3D pdev;
> >       doe_mb->cap_offset =3D cap_offset;
> >       init_waitqueue_head(&doe_mb->wq);
> > -     xa_init(&doe_mb->prots);
> > +     xa_init(&doe_mb->feats);
> >
> >       doe_mb->work_queue =3D alloc_ordered_workqueue("%s %s DOE [%x]", =
0,
> >                                               dev_bus_name(&pdev->dev),
> > @@ -502,11 +502,11 @@ static struct pci_doe_mb *pci_doe_create_mb(struc=
t pci_dev *pdev,
> >
> >       /*
> >        * The state machine and the mailbox should be in sync now;
> > -      * Use the mailbox to query protocols.
> > +      * Use the mailbox to query features.
> >        */
> > -     rc =3D pci_doe_cache_protocols(doe_mb);
> > +     rc =3D pci_doe_cache_features(doe_mb);
> >       if (rc) {
> > -             pci_err(pdev, "[%x] failed to cache protocols : %d\n",
> > +             pci_err(pdev, "[%x] failed to cache features : %d\n",
> >                       doe_mb->cap_offset, rc);
> >               goto err_cancel;
> >       }
> > @@ -515,7 +515,7 @@ static struct pci_doe_mb *pci_doe_create_mb(struct =
pci_dev *pdev,
> >
> >  err_cancel:
> >       pci_doe_cancel_tasks(doe_mb);
> > -     xa_destroy(&doe_mb->prots);
> > +     xa_destroy(&doe_mb->feats);
> >  err_destroy_wq:
> >       destroy_workqueue(doe_mb->work_queue);
> >  err_free:
> > @@ -533,31 +533,31 @@ static struct pci_doe_mb *pci_doe_create_mb(struc=
t pci_dev *pdev,
> >  static void pci_doe_destroy_mb(struct pci_doe_mb *doe_mb)
> >  {
> >       pci_doe_cancel_tasks(doe_mb);
> > -     xa_destroy(&doe_mb->prots);
> > +     xa_destroy(&doe_mb->feats);
> >       destroy_workqueue(doe_mb->work_queue);
> >       kfree(doe_mb);
> >  }
> >
> >  /**
> > - * pci_doe_supports_prot() - Return if the DOE instance supports the g=
iven
> > - *                        protocol
> > + * pci_doe_supports_feat() - Return if the DOE instance supports the g=
iven
> > + *                        feature
> >   * @doe_mb: DOE mailbox capability to query
> > - * @vid: Protocol Vendor ID
> > - * @type: Protocol type
> > + * @vid: Feature Vendor ID
> > + * @type: Feature type
> >   *
> > - * RETURNS: True if the DOE mailbox supports the protocol specified
> > + * RETURNS: True if the DOE mailbox supports the feature specified
> >   */
> > -static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, =
u8 type)
> > +static bool pci_doe_supports_feat(struct pci_doe_mb *doe_mb, u16 vid, =
u8 type)
> >  {
> >       unsigned long index;
> >       void *entry;
> >
> > -     /* The discovery protocol must always be supported */
> > -     if (vid =3D=3D PCI_VENDOR_ID_PCI_SIG && type =3D=3D PCI_DOE_PROTO=
COL_DISCOVERY)
> > +     /* The discovery feature must always be supported */
> > +     if (vid =3D=3D PCI_VENDOR_ID_PCI_SIG && type =3D=3D PCI_DOE_FEATU=
RE_DISCOVERY)
> >               return true;
> >
> > -     xa_for_each(&doe_mb->prots, index, entry)
> > -             if (entry =3D=3D pci_doe_xa_prot_entry(vid, type))
> > +     xa_for_each(&doe_mb->feats, index, entry)
> > +             if (entry =3D=3D pci_doe_xa_feat_entry(vid, type))
> >                       return true;
> >
> >       return false;
> > @@ -585,7 +585,7 @@ static bool pci_doe_supports_prot(struct pci_doe_mb=
 *doe_mb, u16 vid, u8 type)
> >  static int pci_doe_submit_task(struct pci_doe_mb *doe_mb,
> >                              struct pci_doe_task *task)
> >  {
> > -     if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.typ=
e))
> > +     if (!pci_doe_supports_feat(doe_mb, task->feat.vid, task->feat.typ=
e))
> >               return -EINVAL;
> >
> >       if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> > @@ -631,8 +631,8 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, =
u8 type,
> >  {
> >       DECLARE_COMPLETION_ONSTACK(c);
> >       struct pci_doe_task task =3D {
> > -             .prot.vid =3D vendor,
> > -             .prot.type =3D type,
> > +             .feat.vid =3D vendor,
> > +             .feat.type =3D type,
> >               .request_pl =3D request,
> >               .request_pl_sz =3D request_sz,
> >               .response_pl =3D response,
> > @@ -659,7 +659,7 @@ EXPORT_SYMBOL_GPL(pci_doe);
> >   * @vendor: Vendor ID
> >   * @type: Data Object Type
> >   *
> > - * Find first DOE mailbox of a PCI device which supports the given pro=
tocol.
> > + * Find first DOE mailbox of a PCI device which supports the given fea=
ture.
> >   *
> >   * RETURNS: Pointer to the DOE mailbox or NULL if none was found.
> >   */
> > @@ -670,7 +670,7 @@ struct pci_doe_mb *pci_find_doe_mailbox(struct pci_=
dev *pdev, u16 vendor,
> >       unsigned long index;
> >
> >       xa_for_each(&pdev->doe_mbs, index, doe_mb)
> > -             if (pci_doe_supports_prot(doe_mb, vendor, type))
> > +             if (pci_doe_supports_feat(doe_mb, vendor, type))
> >                       return doe_mb;
> >
> >       return NULL;
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_reg=
s.h
> > index e5f558d96493..26ca62bd3473 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -1131,7 +1131,7 @@
> >
> >  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX         0x000000ff
> >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID           0x0000ffff
> > -#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL              0x00ff000=
0
> > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE          0x00ff0000
> >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX    0xff000000
> >
> >  #endif /* LINUX_PCI_REGS_H */
> > --
> > 2.40.1
> >
