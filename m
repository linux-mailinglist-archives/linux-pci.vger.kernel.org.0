Return-Path: <linux-pci+bounces-12921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DE0970188
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 12:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF78B23799
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 10:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C511B14B094;
	Sat,  7 Sep 2024 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="A4HvNY6j"
X-Original-To: linux-pci@vger.kernel.org
Received: from sonic305-19.consmr.mail.sg3.yahoo.com (sonic305-19.consmr.mail.sg3.yahoo.com [106.10.241.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC2BE6C
	for <linux-pci@vger.kernel.org>; Sat,  7 Sep 2024 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725703922; cv=none; b=mBDMPycZBrV9SLe5/AeCtcQtXS8V4CbmDTIgwu9SVpRTX4rhNr0cBIaysm6lGV4I48X0EcRSvyvDqhrz3Shbzy/VWxUAbJR2az0zfsWkGuv5LJP65tOIqCTRgLVv9JY8nGq8+uuTrsMS5nvrp0KOkKcXcmWGDfZthUkEY/P46Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725703922; c=relaxed/simple;
	bh=kkiHYYOtW+BApMBwN6H60TlyXxOO+Zx4IxGpk5W/e1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6I7E4qDO/do2wna122XATIsL+4rynGKDgoqmHzsGupOpb/2TVhFePLB4NoOzPqG4nJyiP7CPbCTPm4ImLteU1Fd15dKY0xQzJL3T+miERxfwJmajG5xSoHoxbpHzkN6XQs36M3qb1lqPBpjEr26ph5B64wCelEFCwBVKLAuwqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=A4HvNY6j; arc=none smtp.client-ip=106.10.241.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1725703913; bh=zkTKJA2FhwivzUz5wJO2Jlnry0Ls8XEBLwuxnqUiJM4=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=A4HvNY6j8WN+DHYNsG3CYj5q9MeLKgWPBz8Y50j+fOi+wdLz8S9kY/H4ENHPfXKplujas5Eu3Nb+Dytqvhf/mVBpvymkePoWZEvheTvg+vlCeOfnIdzT0YNsEjSAj8OFaWotTYZjg844qdV1kw4PMvvyRNnpUoWLism2bUZQyTOLVm/qLv4+NB52sH87JAo9LTCMbNw8+kuhoo98wYH9jSScDJ8mtulLgNwl7kPA1rfDAuzo7OZyU3GNruBh4PvPxbr+EtEO119BdkbUaBavpN4Hr+FvoX2BEsiFqwHP2WYqYujRkk8YyhhHnaVGb9uwMyrEpwVQAEdwwunrRhUB4A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725703913; bh=PKlfI6ejtF957zv0BOG039EtP2cZDnlRKEyeKMeQt5K=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=AVdVy2pRop3YzPaIGT9ilASB7TOep6Zqfp/1+xzlXPS4F5NyN4xmGoLOnDMQwr3VRW3dfep3xHjFKtkZ5ZLBCGxSVfoKLelae8C5PMjL1CIK3/eZHyPvxLXadGbtr6176IelgQ8nUEzQk0CAS7ZsV6xXkmvtISMF5JiDPVCrZ6lVm0wT/Y8eH2DGcg3TcA4GzoPe57nmar/yXfN8EvaquLT/dE8Duwh7JaR8QtIttum6GgbJ/l6cK9XuXkEF1y9lppCNg4U6iimHLYiAWOV8eLv001Y4Kk8UbYR+up+DKS4/FgN/qMlxtW7Y0iVdvGtISdxTqoMJAO/uBtlySQZ67Q==
X-YMail-OSG: 40OVdcgVM1ngXn783d.sjWsogtiPN9AGriMrM4Hf.fdDnv8sNj_4WQc.wHkMzVL
 Y4E4uICd82AqGk_UEJfQxgdT6qTldRfMcSmCZYVrGZGzz1AX0ASOluosqupMG_QRbMTkNDa2Da.S
 aHQlmJQ.JvLZNqdkRv7VpDlfySWfR4oELhr1I1GJ29fz_HsKySlD_S40zbjxZTTHBTW3gDP_JK_w
 QMGdi98a_OSoikDyagzFPjwSc4r3gSmYrLlGnw7Udq7IB6QGU_HLTvGA7LjCphrLieoQIaAkVO1g
 RdlcgMnbrxPHhY9uV4wdctgdBnSycUYyVMlFI5Fvjd25nDnNe2_ASSjE13SgwKcM61YXchm0ucbW
 d2GEau48rhE5wMMlz9kDlt5yqRT8iKjzJDUDFADv7J6XyYgRkwUQsIFND2yXdl0VLNNOgwQeiY5W
 cvpw0_PhaJxsu8W8JodhjGgfMMwramYYR3hKv4BTydDUIgNiYP2u0lzN2GTIsqOJSuBMDUoYv_Lv
 xMr79TL8hju1TkBYIJ6fyTbsnWX7hHeBC2Wu0tobKhfSuyjVrBUoMCoAShHdxeNy2Ue5KvSnIU1k
 sCxDLZkkoYmYOKYJvZRXq9FsI8slBQSLq5A9UV0Rd..lqMkCGozm7coYJhS5m8TZammVRtLOwLUQ
 8h_qtFKUWWnNAlqCy29Bm8h85REe6_mZatKqv5dJXNZpqV3ag_hIKUNwl86dqvRAl7WRpkkfRMMq
 QpVOwfCiWhZeBLEv0cjqaWMJsvHbkRnacNRVZ6e72jeZWlED72JMb2ztiAzyY1udQxyPyJNWIZP7
 EW0kWTsa46kYi7GHEiA3plpvNtL8YA63qbrBKj1W2k7kLGdZUfIP5.H7l9GJMQ_gd1BXjUD3LiJM
 dIfXBwYsNQXfOjaTDmg7F9IjQYU93aGEyM0whXD97R3GzrnAwONLCSLPlw5rSdG1eeM2NfUWvd1m
 T1IxwRAFrWvSxm8t1p8TeXL37KY1DJ5eg_utn2zYxRiwZanWflrL2s1E4uQ8xt7NCqyxt7oV_5V2
 xvUJRM0zcFuXmeMq4T1eSnaCFDhogqb3itFblN4UDKCXxfCm_6Uxj62wx6d21MbusXbSPFN6Vb3E
 GOcJgSjMqPPvEeqeQuHJN50mgyhfcCOb63zcuD8jn2lnfUbRQ5KLNmL4upC_PBmyBfJfqYBOnlx_
 2RX5sQszb3n5W_yM0h._iEvN8uEQcjtpdSGtkHsKueZMsoRROz7P5HZNQ38fSNYz51C1UYxQ9AAR
 Gh6Ra7I4sP1xvNvz_7N1EY.7tf3aNjuaAMrqvF9dn9_vJvBSXOqRX9GwyN7WYqnVJiPFos_rfr4r
 UFGxXpL4LQJr4dSCIlYoouU524.6EPKAHWXhfeM_uD7qzSKjZJEx4oBJX.Ir7xJWsTE8Qavpw6iA
 z6rCzrvhtGHG9cfNCYCKCsBPqcHnPIho7X4GlrsiqGcb65t09hyd_jibooZA6QwmnJbnZ2DoyJK5
 X8x9Es6DcKatzbrvO9WFA25uE56FCSpsGNHA9caoppdUlOuZPcSW4oC5zTs.1FFCC3aO_HghfXvF
 MB.Pf11fTXxPflGpXfMsmsP7qQ4_i4yGapqBlASuvcBOAw0mTzX2zK9i_LQIz1hnXq4rLeJl2UtM
 2_2MoaTIs3IEtonOaHuawO_dwF1N7h6Mg005D_CqpqVmdllrrsAcOMpEmJO_VjfT7mTbbueJFzos
 VHMFEvNpOiqseFwsE4JtbUAKRHAsLrvnuLUJDByai2b_inOUT4Vcjb9X5sJqK.4x_pK66MFUMReu
 Gn7JyxAIzbmq6hBKh9SIs8fT44B3artC_FAapQlvIic1jetvaf59KF1DkTmjUcJFssKjcfzqdzoq
 m6fXAf7w9dJt.0iJG65QEMYSZDVutEhViYJl.nNoSk9ZLNjPg9HVTaij0NfrdDIV8zKYy6oPPMP_
 VcLEghgx4QXSF2goqP3Q6HWnaRI3d4LWoELeBzoOLIM9YQyszX_xrcF_qF7j76px9iVBog2.Bd.e
 5mpIyVVQYGh4dHSVtL6QDiXeqQ995c0bQ0kH5611osX3GEgFwXkX.AgINGEwBPpZDV4Pb2Hh_P_C
 uCHdQc6FjkAdVpoWVarNmAeTujHPEOL7q5sRzO9X9xQQ45lbLvEXfQlOmpjLN5dwt4AF0jOS3JXA
 n76WFWGA8ER5Yucxld1Lke1O.VW2IUZJNwOqnjEDPY_OD_xNHjc1k5J4kzB063mxsviEZcmz63RV
 Xv_Kt_V84YJfBznKabkKe.i4zYdoXMzjJAmS7wFuqvngdnzxL5iP4
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: ddf9fd8a-a61d-455e-a8bb-19462d5aa010
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.sg3.yahoo.com with HTTP; Sat, 7 Sep 2024 10:11:53 +0000
Received: by hermes--production-sg3-fc85cddf6-kdpzj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9082047fd5155f96c2e5472233bc10ec;
          Sat, 07 Sep 2024 10:11:48 +0000 (UTC)
Date: Sat, 7 Sep 2024 15:41:38 +0530
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, bhelgaas@google.com, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] PCI: Fixed spelling in Documentation/PCI/pci.rst
Message-ID: <n7gabykujjulz5dg4eyrc6pcbvn6wzkw6opol3pclaychqnssx@prjklcr7qh34>
References: <u4xan54bdxf5sniwhtvrixw3b2vg4c7magey6q3rsd4ssq6ihk@xfbijuhadyw4>
 <20240906192429.GA430486@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906192429.GA430486@bhelgaas>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Fri, Sep 06, 2024 at 02:24:29PM GMT, Bjorn Helgaas wrote:
> On Sat, Sep 07, 2024 at 12:44:13AM +0530, Abdul Rahim wrote:
> > On Fri, Sep 06, 2024 at 12:53:18PM GMT, Jonathan Corbet wrote:
> > > Abdul Rahim <abdul.rahim@myyahoo.com> writes:
> > > 
> > > > On Fri, Sep 06, 2024 at 11:41:52AM GMT, Bjorn Helgaas wrote:
> > > >> On Fri, Sep 06, 2024 at 06:15:18PM +0530, Abdul Rahim wrote:
> > > >> > Fixed spelling and edited for clarity.
> > > >> > 
> > > >> > Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> > > >> > ---
> > > >> >  Documentation/PCI/pci.rst | 2 +-
> > > >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >> > 
> > > >> > diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> > > >> > index dd7b1c0c21da..344c2c2d94f9 100644
> > > >> > --- a/Documentation/PCI/pci.rst
> > > >> > +++ b/Documentation/PCI/pci.rst
> > > >> > @@ -52,7 +52,7 @@ driver generally needs to perform the following initialization:
> > > >> >    - Enable DMA/processing engines
> > > >> >  
> > > >> >  When done using the device, and perhaps the module needs to be unloaded,
> > > >> > -the driver needs to take the follow steps:
> > > >> > +the driver needs to perform the following steps:
> > > >> 
> > > >> I don't see a spelling fix here, and personally I wouldn't bother with
> > > >> changing "take" to "perform" unless we have other more significant
> > > >> changes to make at the same time.
> > > >
> > > > - "follow" has been corrected to "following", which is more appriopriate
> > > > in this context.
> > > > - I know its trivial, but can disturb the readers flow
> > > > - do you want me to change the message to "Edited for clarity"
> > > 
> > > The problem is not s/follow/following/, it is the other, unrelated
> > > change you made that does not improve the text.  There are reasons why
> > > we ask people not to mix multiple changes.  If you submit just the
> > > "following" fix, it will surely be applied.
> > 
> > Understood, will take care next time. I will resend this patch with:
> > "follow" -> "following", with commit message "Fixed spelling"
> 
> Sorry I missed the "follow" change, which is indeed worth fixing.  If
> you resend it, make your subject and commit log say "fix" (not
> "fixed"), like it's a command.
> 
> https://chris.beams.io/posts/git-commit/
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v6.9#n134
> 

Thanks for reviewing, i've resent this patch here: 
https://lore.kernel.org/lkml/20240906205656.8261-1-abdul.rahim@myyahoo.com/

